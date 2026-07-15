<a id="content_view"></a>

<a id="right-sidebar"></a>

<a id="toc"></a>

<a id="table-of-contents"></a>

# Table of Contents

Overview

[add-listener](#datomic.api/add-listener)

[administer-system](#datomic.api/administer-system)

[as-of](#datomic.api/as-of)

[as-of-t](#datomic.api/as-of-t)

[attribute](#datomic.api/attribute)

[basis-t](#datomic.api/basis-t)

[cancel](#datomic.api/cancel)

[connect](#datomic.api/connect)

[create-database](#datomic.api/create-database)

[datoms](#datomic.api/datoms)

[db](#datomic.api/db)

[db-stats](#datomic.api/db-stats)

[delete-database](#datomic.api/delete-database)

[entid](#datomic.api/entid)

[entid-at](#datomic.api/entid-at)

[entity](#datomic.api/entity)

[entity-db](#datomic.api/entity-db)

[filter](#datomic.api/filter)

[function](#datomic.api/function)

[gc-storage](#datomic.api/gc-storage)

[get-database-names](#datomic.api/get-database-names)

[history](#datomic.api/history)

[ident](#datomic.api/ident)

[implicit-part](#datomic.api/implicit-part)

[implicit-part-id](#datomic.api/implicit-part-id)

[index-pull](#datomic.api/index-pull)

[index-range](#datomic.api/index-range)

[invoke](#datomic.api/invoke)

[is-filtered](#datomic.api/is-filtered)

[list-backups](#datomic.api/list-backups)

[log](#datomic.api/log)

[next-t](#datomic.api/next-t)

[part](#datomic.api/part)

[pull](#datomic.api/pull)

[pull-many](#datomic.api/pull-many)

[q](#datomic.api/q)

[qseq](#datomic.api/qseq)

[query](#datomic.api/query)

[release](#datomic.api/release)

[remove-tx-report-queue](#datomic.api/remove-tx-report-queue)

[rename-database](#datomic.api/rename-database)

[request-index](#datomic.api/request-index)

[resolve-tempid](#datomic.api/resolve-tempid)

[rseek-datoms](#datomic.api/rseek-datoms)

[seek-datoms](#datomic.api/seek-datoms)

[shutdown](#datomic.api/shutdown)

[since](#datomic.api/since)

[since-t](#datomic.api/since-t)

[squuid](#datomic.api/squuid)

[squuid-time-millis](#datomic.api/squuid-time-millis)

[sync](#datomic.api/sync)

[sync-excise](#datomic.api/sync-excise)

[sync-index](#datomic.api/sync-index)

[sync-schema](#datomic.api/sync-schema)

t-\>tx

[tempid](#datomic.api/tempid)

[touch](#datomic.api/touch)

[transact](#datomic.api/transact)

[transact-async](#datomic.api/transact-async)

tx-\>t

[tx-range](#datomic.api/tx-range)

[tx-report-queue](#datomic.api/tx-report-queue)

[with](#datomic.api/with)

  
<a id="content-tag"></a>

<a id="overview"></a>

## API for <a id="namespace-name"></a>datomic.api - <a id="header-project"></a>Datomic Clojure <a id="header-version"></a>

  
Full namespace name: <a id="long-name"></a>datomic.api
<a id="overview-2"></a>

## Overview

<a id="namespace-docstr"></a>

```
```

  
<a id="public-variables-and-functions"></a>

## Public Variables and Functions

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/add-listener"></a>

## add-listener

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (add-listener fut f executor)
```

<a id="var-docstr"></a>

```
Register a completion listener for the future. The listener
will run once and only once, if and when the future's work is
complete. If the future has completed already, the listener will
run immediately.  Ordering of listeners is not guaranteed.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/administer-system"></a>

## administer-system

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (administer-system options)
```

<a id="var-docstr"></a>

```
Administer system. Takes an options map with a required :action key.
Throws on failure. Actions include:

Release Object Cache
:action      :release-object-cache

Effect: Clear all entries from the Object Cache.

Upgrade Schema
:action      :upgrade-schema
:uri         a URI as per connect

Effect: Upgrades the base schema of a database to the latest version.
NOTE: Read datomic deployment before calling.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/as-of"></a>

## as-of

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (as-of db t)
```

<a id="var-docstr"></a>

```
Returns the value of the database as of some point t, inclusive.
t can be a transaction number, transaction ID, or Date.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/as-of-t"></a>

## as-of-t

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (as-of-t db)
```

<a id="var-docstr"></a>

```
Returns the as-of point, or nil if none
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/attribute"></a>

## attribute

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (attribute db attrid)
```

<a id="var-docstr"></a>

```
Returns information about the attribute with the given id or ident.
Supports ILookup interface for key-based access. Supported keys are:

:id, :ident, :cardinality, :value-type, :unique, :indexed, :has-avet,
:no-history, :is-component, :fulltext
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/basis-t"></a>

## basis-t

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (basis-t db)
```

<a id="var-docstr"></a>

```
Returns the t of the most recent transaction reachable via this db value.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/cancel"></a>

## cancel

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (cancel {:keys [cognitect.anomalies/category], :as anomaly-map})
```

<a id="var-docstr"></a>

```
Cancels the current Datomic operation (query or transaction).

Throws an ex-info with an anomaly to the original caller.

anomaly-map is an anomaly as described by https://github.com/cognitect-labs/anomalies.

:cognitect.anomalies/category is a required key, valid values are:

  :cognitect.anomalies/incorrect
  :cognitect.anomalies/conflict

When :cognitect.anomalies/message is provided, the message will be used as the Exception's detail message

Other keys should be namespace-qualified.

All data passed to cancel must be fressian-serializable.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/connect"></a>

## connect

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (connect uri)
```

<a id="var-docstr"></a>

```
Connects to the specified database, returning a Connection.
URI syntax ({} indicate place holders to fill in, [] indicate optional):

DynamoDB using roles:
datomic:ddb://{aws-region}/{dynamodb-table}/{db-name}

DynamoDB using keys (use roles if possible):
datomic:ddb://{aws-region}/{dynamodb-table}/{db-name}?aws_access_key_id={XXX}&aws_secret_key={YYY}

DynamoDB Local:
datomic:ddb-local://{endpoint:port}/{dynamodb-table}/{db-name}?aws_access_key_id={XXX}&aws_secret_key={YYY}

Couchbase:
datomic:couchbase://{host}/{bucket}/{dbname}[?password={xxx}]

SQL:
datomic:sql://{db-name}?{jdbc-uri}
datomic:sql://{db-name}?{query-string}#{jdbc-uri}

Infinispan:
datomic:inf://{cluster-member-host}:{port}/{db-name}

Cassandra:
datomic:cass://{cluster-member-host}[:{port}]/{keyspace}.{table}/{db-name}[?user={user}&password={pwd}][&ssl=true]

Cassandra3:
datomic:cass3://{cluster-member-host}[:{port}]/{keyspace}.{table}/{db-name}[?user={user}&password={pwd}][&ssl=true][&local-datacenter=datacenter1]

Backups:
datomic:backup:{backup-uri}[?t={backup-t}]
Backup connections will read the latest backup unless given a t parameter. Connections to
backups are always read-only, supporting only d/db and d/log. See also d/list-backups.

Dev Appliance:
datomic:dev://{transactor-host}:{port}/{db-name}[?password={password}]

Free transactor integrated storage:
datomic:free://{transactor-host}:{port}/{db-name}[?password={password}]

In-process Memory:
datomic:mem://{db-name}

Note that query param values must be URL-encoded, and db-name cannot contain the following characters: / " * : = ?

The dev and free protocols use additional ports to communicate with
storage.  By default, this ports is one higher than the specified
transactor port. You can override the default by specifying h2-port
in the query string, e.g.

  datomic:dev://localhost:4334/mydb?h2-port=6000

The sql protocol also supports a map format instead of the URI
string. This is to enable specifying objects that can't be
embedded in URI strings, like DataSources. The format for the
SQL map is:

  {:protocol :sql                  ;; keyword or string
   :db-name "myDb"               ;; keyword or string

   :data-source aDataSourceObject
    ;; OR
   :factory aCallableReturningConnection}

Note only one of data-source or factory should be supplied.

The cass protocol also supports a map format instead of the URI
string. This is to enable specifying objects that can't be embedded
in URI strings. The format for the Cassandra map is:

  {:protocol :cass                 ;; keyword or string
   :db-name "myDb"               ;; keyword or string
   :table "myKeyspace.myTable"
   :cluster aClusterObject}

Note that aClusterObject must be an instance of type
com.datastax.driver.core.Cluster.

The cass3 protocol also supports a map format instead of the URI
string. This is to enable specifying objects that can't be embedded
in URI strings. The format for the Cassandra map is:

  {:protocol :cass                 ;; keyword or string
   :db-name "myDb"               ;; keyword or string
   :table "myKeyspace.myTable"
   :session aSessionObject}

Note that aSessionObject must be an instance of type
com.datastax.oss.driver.api.core.cql.SyncCqlSession.

d/connect returns a read-only connection when given a URI with
query param read-only=true. These connections do not require a
running transactor, and support only d/db and d/log APIs, which
will always return the same value read at connection time.

Datomic connections do not adhere to an acquire/use/release
pattern. They are thread-safe and long lived. Connections are
cached such that calling datomic.api/connect multiple times with
the same database URI will return the same connection object.
Read-only connections are not cached.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/create-database"></a>

## create-database

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (create-database uri)
```

<a id="var-docstr"></a>

```
Creates database specified by uri. Returns true if the
database was created, false if it already exists. See connect
for a description of the URI syntax.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/datoms"></a>

## datoms

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (datoms db index & components)
```

<a id="var-docstr"></a>

```
Raw access to the index data, by index. The index must be supplied,
and, optionally, one or more leading components of the index can be
supplied to narrow the result.

:eavt and :aevt indexes will contain all datoms
:avet contains datoms for attributes where :db/index = true.
:vaet contains datoms for attributes of :db.type/ref
      :vaet is the reverse index

Returns a java.lang.Iterable of datoms. Datoms are associative and indexed:

Key     Index        Value
--------------------------
:e      0            entity id
:a      1            attribute id
:v      2            value
:tx     3            transaction id
:added  4            boolean add/retract
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/db"></a>

## db

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (db connection)
```

<a id="var-docstr"></a>

```
Retrieves a value of the database for reading. Does not
communicate with the transactor, nor block.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/db-stats"></a>

## db-stats

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (db-stats db)
```

<a id="var-docstr"></a>

```
Queries for database stats. Returns a map including at least:
:datoms  total count of datoms in the (history) database
```

<a id="content"></a>Added in Datomic Clojure version 1.0.6333  
<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/delete-database"></a>

## delete-database

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (delete-database uri)
```

<a id="var-docstr"></a>

```
Deletes the database specified by uri. Returns true if the
delete occurred. See connect for a description of the URI
syntax.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/entid"></a>

## entid

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (entid db ident)
```

<a id="var-docstr"></a>

```
Returns the entity id associated with a symbolic keyword, or the id
itself if passed.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/entid-at"></a>

## entid-at

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (entid-at db part t-or-date)
```

<a id="var-docstr"></a>

```
Returns a fabricated entity id in the supplied partition whose
T component is at or after the supplied t. Entity ids sort by partition,
then T component, such T components interleaving with transaction numbers.
Thus this function can be used to fabricate a time-based entity id component for use
in e.g. seek-datoms.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/entity"></a>

## entity

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (entity db eid)
```

<a id="var-docstr"></a>

```
Returns a dynamic map of the entity's attributes for the given id, ident or lookup ref.
Entities implement
  clojure.lang.Associative
  clojure.lang.ILookup
  clojure.lang.IPersistentCollection
  clojure.lang.Seqable
  datomic.Entity
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/entity-db"></a>

## entity-db

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (entity-db entity)
```

<a id="var-docstr"></a>

```
Returns the database value that is the basis for this entity
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/filter"></a>

## filter

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (filter db pred)
```

<a id="var-docstr"></a>

```
Returns the value of the database containing only datoms
satisfying the predicate. the predicate will be passed two arguments -
the unfiltered db and a Datom. Chained calls compose the predicate with
'and'
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/function"></a>

## function

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (function m)
```

<a id="var-docstr"></a>

```
Generates a function object given a map with required keys

:lang  - clojure or java
:params - a list of parameter names used in the code
:code - a string or data containing the code of the body

and optional keys

:imports - a list to be spliced into (import ...)
:requires - a list to be spliced into (require ...)

Clojure code should consist of a single expression in which
the params will be in scope.

Returns a function object that implements IFn, and is a record with
keys :lang, :params, :code, :imports, and :requires.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/gc-storage"></a>

## gc-storage

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (gc-storage connection older-than)
```

<a id="var-docstr"></a>

```
Allow storage to reclaim garbage older than a certain age.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/get-database-names"></a>

## get-database-names

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (get-database-names uri)
```

<a id="var-docstr"></a>

```
Returns a list of database names. URI is a database URI as
described under the connect documentation, but with a '*' where the
database name would be. For instance: datomic:dev://{transactor-host}:{port}/*.
When using the map form, :db-name should be omitted.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/history"></a>

## history

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (history db)
```

<a id="var-docstr"></a>

```
Returns a special database containing all assertions and
retractions across time. This special database can be used for
datoms and index-range calls and queries, but not for entity or
with calls. as-of and since bounds are also supported. Note that
queries will get all of the additions and retractions, which can be
distinguished by the fifth datom field :added (true for add/assert)
[e a v tx added]
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/ident"></a>

## ident

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (ident db eid)
```

<a id="var-docstr"></a>

```
Returns the keyword associated with an id, or the key itself if passed.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/implicit-part"></a>

## implicit-part

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (implicit-part id)
```

<a id="var-docstr"></a>

```
Returns the implicit partition (an entity id) corresponding to the given id, where 0<=id<524288.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/implicit-part-id"></a>

## implicit-part-id

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (implicit-part-id part)
```

<a id="var-docstr"></a>

```
Returns the id of the given implicit partition, where 0<=id<524288. Returns nil when arg not an implicit partition.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/index-pull"></a>

## index-pull

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (index-pull db arg-map)
```

<a id="var-docstr"></a>

```
Walks an index, pulling entities via :e if :avet or :v if :aevt,
using the selector, returning a lazy seq on the results.

:index     :avet or :aevt
:selector  a pull selector (see 'pull')
:start     A vector in the same order as the index indicating
           the initial position. At least :a must be specified.
           Iteration is limited to datoms matching :a.
:reverse   optional, when true iterate the index in reverse
           order
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/index-range"></a>

## index-range

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (index-range db attrid start end)
```

<a id="var-docstr"></a>

```
Returns an Iterable range of datoms in index named by attrid,
starting at start, or from beginning if start is nil, and ending
before end, or through end of attr index if end is nil.

See datoms for a description of the returned value.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/invoke"></a>

## invoke

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (invoke db eid-or-ident & args)
```

<a id="var-docstr"></a>

```
Lookup the database function named by eid-or-ident, and call it with args.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/is-filtered"></a>

## is-filtered

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (is-filtered db)
```

<a id="var-docstr"></a>

```
Returns true if db has had a filter set with filter
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/list-backups"></a>

## list-backups

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (list-backups backup-uri)
```

<a id="var-docstr"></a>

```
Lists all points in time available at the given backup-uri. Returns a map
with :backups, sorted descending by t.
Each backup contains:
:t            the basis t of the backup
:connect-uri  a URI that can be passed to d/connect
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/log"></a>

## log

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (log connection)
```

<a id="var-docstr"></a>

```
Retrieves a value of the log for use in tx-range or query.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/next-t"></a>

## next-t

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (next-t db)
```

<a id="var-docstr"></a>

```
Returns the t one beyond the highest reachable via this db value.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/part"></a>

## part

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (part eid)
```

<a id="var-docstr"></a>

```
Return the partition associated with an entity id.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/pull"></a>

## pull

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (pull db pattern eid & {:as options})
```

<a id="var-docstr"></a>

```
Like pull-many, but takes a single eid.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/pull-many"></a>

## pull-many

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (pull-many db pattern eids & {:as options})
```

<a id="var-docstr"></a>

```
Returns hierarchical selections of attributes for eids.
See pull for more information.

You can get information about the I/O reads performed by a
pull with io-stats. To request io-stats, pass :io-context
(a qualified keyword) as an option to pull-many. The return
value will be a map with

:ret                the result of the pull
:io-stats           io-stats for the pull

The io-stats map includes:

:io-context         the io-context passed in
:api                :tx-with
:api-ms             msec to peform the API call
:reads              breakout of reads by cache tier and index sort
:nested             breakout iff nested queries set :io-context

See io stats.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/q"></a>

## q

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (q query & inputs)
```

<a id="var-docstr"></a>

```
Executes a query against inputs.

 Inputs are data sources e.g. a database value retrieved from
 Connection.db, a list of lists, and/or rules. If only one data
 source is provided, no :in section is required, else the :in
 section describes the inputs.

 query can be a map, list, or string:

 The query map form is {:find vars-and-aggregates
                        :with vars-included-but-not-returned
                        :in sources
                        :where clauses}
 where vars, sources and clauses are lists.

:with is optional, and names vars to be kept in the aggregation set but
 not returned.

 The query list form is [:find ?var1 ?var2 ...
                         :with ?var3 ...
                         :in $src1 $src2 ...
                         :where clause1 clause2 ...]
 The query list form is converted into the map form internally.

 The query string form is a string which, when read, results
 in a query list form or query map form.

 Query parse results are cached.

 Returns a data structure based on the find specification passed in.
 See find-specs.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/qseq"></a>

## qseq

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (qseq query-map)
```

<a id="var-docstr"></a>

```
Performs the query described by query-map (as per 'query'),
returning a lazy seq on the results.  Item transformations such as
'pull' are deferred until the seq is consumed. For queries with
pull(s), this results in:

* reduced memory use and the ability to execute larger queries
* lower latency before the first results are returned

The returned seq object efficiently supports 'count'.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/query"></a>

## query

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (query query-map)
```

<a id="var-docstr"></a>

```
Executes the query described by query-map

query-map form is {:query query
                   :args args
                   :timeout time-in-milliseconds
                   :io-context qualified-keyword}

The query parameter is the same format as described in q.

The args parameter is the same format as inputs described in q.

The optional timeout is the number of milliseconds after which a
query may be stopped. Note: timeout is approximate, it is meant to
protect against long running queries, but is not guaranteed to stop
after precisely the duration specified.

You can get information about the I/O reads performed by a query
with io-stats. To request io-stats, add :io-context (a qualified
keyword) to the map you use to call query. Query will return a map
with

:ret                the result of the query
:io-stats           io-stats for the query

The io-stats map includes:

:io-context         the io-context passed in
:api                :tx-with
:api-ms             msec to perform the API call
:reads              breakout of reads by cache tier and index sort
:nested             breakout iff nested queries set :io-context

See io stats.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/release"></a>

## release

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (release conn)
```

<a id="var-docstr"></a>

```
Request the release of resources associated with this connection.
Method returns immediately, resources will be released
asynchronously. This method should only be called when the entire
process is no longer interested in the connection. Note
that Datomic connections do not adhere to an acquire/use/release
pattern.  They are thread-safe, cached, and long lived.  Many
processes (e.g. application servers) will never call release.
```

<a id="content"></a>Added in Datomic Clojure version 0.8.3861  
<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/remove-tx-report-queue"></a>

## remove-tx-report-queue

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (remove-tx-report-queue connection)
```

<a id="var-docstr"></a>

```
Removes the queue associated with this connection.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/rename-database"></a>

## rename-database

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (rename-database uri new-name)
```

<a id="var-docstr"></a>

```
Renames the database specified by uri to new-name. Returns
true if rename succeeded. See connect for a description of the
URI syntax.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/request-index"></a>

## request-index

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (request-index connection)
```

<a id="var-docstr"></a>

```
Schedules a re-index of the database. The re-indexing happens
asynchronously. Returns true if re-index is scheduled.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/resolve-tempid"></a>

## resolve-tempid

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (resolve-tempid db tempids tempid)
```

<a id="var-docstr"></a>

```
Resolve a tempid to the actual id assigned in a database. The
tempids object must come from the :tempids member returned through
transact or transact-async.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/rseek-datoms"></a>

## rseek-datoms

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (rseek-datoms db index & components)
```

<a id="var-docstr"></a>

```
Like seek-datoms, but iterates the index in reverse, beginning at or before the point where the given
components would reside.

Only terminates at the start of the index, thus callers must supply their own termination logic.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/seek-datoms"></a>

## seek-datoms

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (seek-datoms db index & components)
```

<a id="var-docstr"></a>

```
Raw access to the index data, by index. The index must be supplied,
and, optionally, one or more leading components of the index can be supplied for the initial search.
Note that, unlike the datoms function, there need not be an exact match on the supplied components.
The iteration will begin at or after the point in the index where the components would reside.
Further, the iteration is not bound by the supplied components, and will only terminate
at the end of the index. Thus you will have to supply your own termination logic, as you rarely
want the entire index. As such, seek-datoms is for more advanced applications, and datoms should be preferred
wherever it is adequate. See also - entid-at.

      :eavt and :aevt indexes will contain all datoms
      :avet contains datoms for attributes where :db/index = true.
      :vaet contains datoms for attributes of :db.type/ref
      :vaet is the reverse index

      See datoms for a description of the returned value.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/shutdown"></a>

## shutdown

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (shutdown shutdown-clojure)
```

<a id="var-docstr"></a>

```
Shutdown all peer resources.  This method should be called as
part of clean shutdown of a JVM process.  Will release all Connections,
and, if shutdown-clojure is true, will release Clojure resources.
Programs written in Clojure can set shutdown-clojure to false if they
manage Clojure resources (e.g. agents) outside of Datomic; programs
written in other JVM languages should typically set shutdown-clojure
to true.
```

<a id="content"></a>Added in Datomic Clojure version 0.8.3861  
<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/since"></a>

## since

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (since db t)
```

<a id="var-docstr"></a>

```
Returns the value of the database since some point t, exclusive
t can be a transaction number, transaction ID, or Date.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/since-t"></a>

## since-t

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (since-t db)
```

<a id="var-docstr"></a>

```
Returns the since point, or nil if none
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/squuid"></a>

## squuid

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (squuid)
```

<a id="var-docstr"></a>

```
Constructs a semi-sequential UUID. Useful for creating UUIDs
that don't fragment indexes. Returns a UUID whose most significant
32 bits are currentTimeMillis rounded to seconds.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/squuid-time-millis"></a>

## squuid-time-millis

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (squuid-time-millis squuid)
```

<a id="var-docstr"></a>

```
get the time part of a squuid (a UUID created by squuid), in
the format of System.currentTimeMillis
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/sync"></a>

## sync

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (sync connection)
       (sync connection t)
```

<a id="var-docstr"></a>

```
Used to coordinate with other peers.

When called with a t: returns a future that will acquire a
database value with basisT >= t. Does not communicate with the
transactor.

When called with no t: Returns a future that will acquire a
database value guaranteed to include all transactions that were
complete at the time sync was called.  Communicates with the
transactor.

db is the preferred way to get a database value, as it does not
need to wait nor block. Only use sync when coordination is
required, and prefer the two-argument version when you have a
basis t.

The future returned by sync can take arbitrarily long to
complete.  Waiters should use deref forms that specify a timeout.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/sync-excise"></a>

## sync-excise

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (sync-excise connection t)
```

<a id="var-docstr"></a>

```
Used to coordinate with background excision. Returns a
future that will acquire a database value that is aware of
excisions through time <= t.

Does not communicate with the transactor, so the future may be
available immediately.

The future can take arbitrarily long to complete.  Waiters
should specify a timeout.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/sync-index"></a>

## sync-index

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (sync-index connection t)
```

<a id="var-docstr"></a>

```
Used to coordinate with background indexing jobs. Returns a
future that will acquire a database value that is indexed
through time <= t.

Does not communicate with the transactor, so the future may be
available immediately.

The future can take arbitrarily long to complete.  Waiters
should specify a timeout.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/sync-schema"></a>

## sync-schema

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (sync-schema connection t)
```

<a id="var-docstr"></a>

```
Used to coordinate with background schema changes. Returns a
future that will acquire a database value that is aware of
all schema changes through time <= t.

Does not communicate with the transactor, so the future may be
available immediately.

The future can take arbitrarily long to complete.  Waiters
should specify a timeout.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="t-tx"></a>

## t-\>tx

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (t->tx t)
```

<a id="var-docstr"></a>

```
Return the transaction id associated with a t value.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/tempid"></a>

## tempid

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (tempid partition)
       (tempid partition n)
```

<a id="var-docstr"></a>

```
Generate a tempid in the specified partition. Within the scope
of a single transaction, tempids map consistently to permanent
ids. Values of n from -1 to -1000000, inclusive, are reserved for
user-created tempids.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/touch"></a>

## touch

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (touch entity)
```

<a id="var-docstr"></a>

```
Touches all of the attributes of the entity, including any component entities recursively.
Returns the entity.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/transact"></a>

## transact

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (transact connection tx-data & {:as options})
```

<a id="var-docstr"></a>

```
Given a connection and a set of information (tx-data), submits
a transaction, blocking until a result is available. d/transact
updates the connection's shared reference to the value of the
database by swapping in the result of d/with.

Returns a completed future. See d/with for a description of
tx-data and the return map that will be placed in the future.

An exception indicates either that a transaction failed, or
that the result of the transaction is not known after a
communication failure. For detailed information on programmatic
error handling, see error handling.
Note that an exception may occur either when invoking the API
or when dereferencing the returned reference.

See io stats for how
to get information about I/O reads performed by a transaction
if the connection supports io-stats.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/transact-async"></a>

## transact-async

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (transact-async connection tx-data & {:as options})
```

<a id="var-docstr"></a>

```
Same as transact, but returns its future immediately.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="tx-t"></a>

## tx-\>t

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (tx->t tx)
```

<a id="var-docstr"></a>

```
Return the t value associated with a transaction id.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/tx-range"></a>

## tx-range

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (tx-range log start end)
```

<a id="var-docstr"></a>

```
Returns a range of transactions in log, starting at start,
or from beginning if start is nil, and ending before end, or through
end of log if end is nil. start and end can be can be a transaction
number, transaction ID, Date or nil.

Each transaction is a map with the following keys:
 :t - the T point of the transaction
 :data -  a Collection of the Datoms asserted/retracted by the transaction
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/tx-report-queue"></a>

## tx-report-queue

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (tx-report-queue connection)
```

<a id="var-docstr"></a>

```
Gets the data queue associated with this connection, creating one
if necessary. At any point in time either zero or one queue is
associated with a connection. The returned queue may be consumed
from more than one thread. Note that the returned queue does not
block producers, and will consume memory until you consume the
elements from it. Reports will be added to the queue at some point
after the db has been updated. If this connection originated the
transaction, the transaction future will be notified first, before
a report is placed on the queue.

Reports are records with the following keys:

  :db-before    value of database before the transaction
  :db-after     value of database after the transaction
  :tx-data      the transaction data in E/A/V/Tx form.
```

<a id="var-entry"></a>

  

------------------------------------------------------------------------

<a id="datomic.api/with"></a>

## with

<a id="var-type"></a>function  
<a id="var-usage"></a>

```
Usage: (with db tx-data)
```

<a id="var-docstr"></a>

```
d/with is a pure function that takes a database value and a
set of information (tx-data; held to be true at a point in time),
and returns a new database value that includes, via accretion,
that new information.

The tx-data argument is semantically an unordered set of information.
Syntactically it is a list that can include primitive assertions,
entity maps, and transaction functions.
See transaction data.

If the tx-data is valid, returns a map containing the following keys:
 :db-before  database value before the transaction
 :db-after   database value after the transaction
 :tx-data    collection of Datoms produced by the transaction
 :tempids    argument to resolve-tempids

See d/datoms for a description of :tx-data.

Optional args:
 :io-context a qualified keyword
 When provided, the return map will have an additional :io-stats key describing
 information about the I/O reads performed by the call to d/with.
 For more detail, see io stats.

 :return-hints true
 When provided, the return map may also include an additional key :hints,
 an opaque value that can be passed as an option to d/transact or d/transact-async
 to optimize performance.
 For more detail, see reducing latency with transaction hints.
```
