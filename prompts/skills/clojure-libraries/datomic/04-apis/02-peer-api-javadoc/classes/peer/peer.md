Package [datomic](../../peer-api-javadoc.md)
<a id="class-peer"></a>

# Class Peer

[java.lang.Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

datomic.Peer
<a id="class-description"></a>

------------------------------------------------------------------------

public class Peer extends [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

Main entry point, used to manage connections, submit transactions, and query.

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`administerSystem`](#administerSystem(java.util.Map))`(`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")` options)`
  Administer a Datomic system.
  `static void`
  [`cancel`](#cancel(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` anomaly)`
  Cancels the current Datomic operation (query or transaction).
  `static `[`Connection`](../../interfaces/connection/connection.md "interface in datomic")
  [`connect`](#connect(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` uriOrMap)`
  Connects to the specified database.
  `static boolean`
  [`createDatabase`](#createDatabase(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` uriOrMap)`
  Creates a database with the given name.
  `static boolean`
  [`deleteDatabase`](#deleteDatabase(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` uriOrMap)`
  Deletes a database.
  `static datomic.functions.Fn`
  [`function`](#function(java.util.Map))`(`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")` m)`
  Generates a function object given a map of :lang - clojure or java :params - a list of parameter names used in the code :code - a string containing the code of the function body.
  `static `[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")`<`[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")`>`
  [`getDatabaseNames`](#getDatabaseNames(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` uriOrMap)`
  Returns a list of database names.
  `static `[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`<`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`,`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`>`
  [`listBackups`](#listBackups(java.lang.String))`(`[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")` backupUri)`
  Lists all points in time available at the given `backup-uri`.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`part`](#part(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` entityId)`
  Returns the partition of this [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities).
  `static `[`Collection`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Collection.html "class or interface in java.util")`<`[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")`<`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`>>`
  [`q`](#q(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` query, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... inputs)`
  Like [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...)), but with a more specific return signature.
  `static `[`Stream`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream")`<`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`>`
  [`qseq`](#qseq(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` query, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... inputs)`
  Performs the query described by `query` and `inputs` (as per [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...))), Item transformations such as pull are deferred until the Stream is consumed.
  `static <T> T`
  [`query`](#query(datomic.QueryRequest))`(`[`QueryRequest`](../query-request/query-request.md "class in datomic")` queryRequest)`
  Like [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...)), but accepts a [`QueryRequest`](../query-request/query-request.md "class in datomic") object.
  `static <T> T`
  [`query`](#query(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` query, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... inputs)`
  Executes a [datalog query](../../../../06-reference/03-query-and-pull/query-and-pull.md).
  `static boolean`
  [`renameDatabase`](#renameDatabase(java.lang.Object,java.lang.String))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` uriOrMap, `[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")` newName)`
  Renames a database.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`resolveTempid`](#resolveTempid(datomic.Database,java.lang.Object,java.lang.Object))`(`[`Database`](../../interfaces/database/database.md "interface in datomic")` db, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` tempids, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` tempid)`
  Resolve a tempid to the actual id assigned in a database.
  `static void`
  [`shutdown`](#shutdown(boolean))`(boolean shutdownClojure)`
  Shutdown all peer resources.
  `static `[`UUID`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html "class or interface in java.util")
  [`squuid`](#squuid())`()`
  Constructs a semi-sequential UUID.
  `static long`
  [`squuidTimeMillis`](#squuidTimeMillis(java.util.UUID))`(`[`UUID`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html "class or interface in java.util")` squuid)`
  Get the time component of a squuid.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`tempid`](#tempid(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` partition)`
  Generates a temp id in the designated partition.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`tempid`](#tempid(java.lang.Object,long))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` partition, long idNumber)`
  Generates a temp id in the designated partition.
  `static long`
  [`toT`](#toT(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` tx)`
  Returns the t value associated with this tx.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`toTx`](#toTx(long))`(long t)`
  Returns the tx associated with this t value.
  <a id="methods-inherited-from-class-java.lang.Object"></a>

  ### Methods inherited from class java.lang.[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

  [`clone`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#clone() "class or interface in java.lang")`, `[`equals`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object) "class or interface in java.lang")`, `[`finalize`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#finalize() "class or interface in java.lang")`, `[`getClass`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#getClass() "class or interface in java.lang")`, `[`hashCode`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#hashCode() "class or interface in java.lang")`, `[`notify`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notify() "class or interface in java.lang")`, `[`notifyAll`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notifyAll() "class or interface in java.lang")`, `[`toString`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#toString() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long) "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long,int) "class or interface in java.lang")


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="connect(java.lang.Object)"></a>

    <a id="connect"></a>

    ### connect

    public static [Connection](../../interfaces/connection/connection.md "interface in datomic") connect([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") uriOrMap)
    Connects to the specified database. The systemId and credentials are defined when a new Datomic instance is provisioned.
    URI syntax:

    ``` datomic-plain-fence
     ;;dynamo using roles
     datomic:ddb://{aws-region}/{dynamodb-table}/{db-name}

     ;;dynamo using keys, use roles if possible
     datomic:ddb://{aws-region}/{dynamodb-table}/{db-name}?aws_access_key_id={XXX}&aws_secret_key={YYY}

     ;; dynamo local
     datomic:ddb-local://{endpoint}:{port}/{dynamodb-table}/{db-name}?aws_access_key_id={XXX}&aws_secret_key={YYY}

     ;; sql
     datomic:sql://{db-name}?{jdbc-uri}
     datomic:sql://{db-name}?{query-string}#{jdbc-uri}

     ;; infinispan
     datomic:inf://{cluster-member-host}:{port}/{db-name}

     ;; cassandra
     datomic:cass://{cluster-member-host}[:{port}]/{keyspace}.{table}/{db-name}[?user={user}&password={pwd}][&ssl=true]

     ;; Cassandra3
     datomic:cass3://{cluster-member-host}[:{port}]/{keyspace}.{table}/{db-name}[?user={user}&password={pwd}][&ssl=true][&local-datacenter=datacenter1]

     ;; Backups
     datomic:backup:{backup-uri}[?t={backup-t}]
     Backup connections will read the latest backup unless given a t parameter. Connections to
     backups are always read-only, supporting only d/db and d/log. See also d/list-backups.

     ;; dev appliance
     datomic:dev://{transactor-host}:{port}/{db-name}[?password={password}]

     ;; limited-edition transactor integrated storage
     datomic:limited-edition://{transactor-host}:{port}/{db-name}[?password={password}]

     ;; in-process memory
     datomic:mem://{db-name}
     
    ```

    Note that query param values must be URL-encoded, and db-name cannot contain the following characters: / " \* : = ?

    The dev, free, and limited-edition protocols use an additional ports to communicate with storage. By default this port is one higher than the specified transactor port. You can override the default by specifying h2-port in the query string, e.g.
    ``` datomic-plain-fence
     datomic:limited-edition://localhost:4334/mydb?h2-port=6000&
     
    ```

    The sql protocol also supports a map format for the connection params. This is to enable communicating objects that can't be embedded in URI strings, like DataSources. The format for the map is:
    ``` datomic-plain-fence
         {
         :protocol :sql
         :db-name "myDb"

         :data-source aDataSourceObject
         ;; OR
         :factory aCallableReturningConnection
         }
     
    ```

    Note only one of data-source or factory should be supplied. The keys and protocol name can be keywords or strings.
    The cass protocol also supports a map format for the connection params. The format for the map is:

    ``` datomic-plain-fence
         {
         :protocol :cass
         :db-name "myDb"
         :table "myKeyspace.myTable"

         :cluster aClusterObject
         }
     
    ```

    Note aClusterObject must be an instance of type com.datastax.driver.core.Cluster. The keys and protocol name can be keywords or strings.
    The cass3 protocol also supports a map format for the connection params. The format for the map is:

    ``` datomic-plain-fence
          {
          :protocol :cass3
          :db-name "myDb"
          :table "myKeyspace.myTable"
          :session aSessionObject
          }
     
    ```

    Note that aSessionObject must be an instance of type com.datastax.oss.driver.api.core.cql.SyncCqlSession. The keys and protocol name can be keywords or strings.
    `d/connect` returns a read-only connection when given a URI with query param `read-only=true`. These connections do not require a running transactor, and support only `d/db` and `d/log` APIs, which will always return the same value read at connection time.

    Datomic connections do not adhere to an acquire/use/release pattern. They are thread-safe and long lived. Connections are cached such that calling Peer.connect(uri) multiple times with the same URI value will return the same connection object. Read-only connections are not cached.

    Parameters:  
    `uriOrMap` - a Datomic connection URI string, or parameters map if supported by the protocol.

    Returns:  
    a connection to the database.

  - <a id="createDatabase(java.lang.Object)"></a>

    <a id="createdatabase"></a>

    ### createDatabase

    public static boolean createDatabase([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") uriOrMap)
    Creates a database with the given name. The systemId and credentials are defined when a new Datomic instance is provisioned. Idempotent.
    Parameters:  
    `uriOrMap` - the uri of the database to create.

    Returns:  
    ``` datomic-plain-fence
    true
    ```

    if the database was created,

    ``` datomic-plain-fence
    false
    ```

    if the database already exists.

  - <a id="renameDatabase(java.lang.Object,java.lang.String)"></a>

    <a id="renamedatabase"></a>

    ### renameDatabase

    public static boolean renameDatabase([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") uriOrMap, [String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") newName)
    Renames a database.
    Parameters:  
    `uriOrMap` - same as in \#connect(Object)

    `newName` - the new name of the database. This is the database name only and should not be a URI.

    Returns:  
    ``` datomic-plain-fence
    true
    ```

    if rename succeeded

  - <a id="deleteDatabase(java.lang.Object)"></a>

    <a id="deletedatabase"></a>

    ### deleteDatabase

    public static boolean deleteDatabase([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") uriOrMap)
    Deletes a database.
    Parameters:  
    `uriOrMap` - same as in \#connect(Object)

    Returns:  
    ``` datomic-plain-fence
    true
    ```

    if delete occurred.

  - <a id="getDatabaseNames(java.lang.Object)"></a>

    <a id="getdatabasenames"></a>

    ### getDatabaseNames

    public static [List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")\<[String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")\> getDatabaseNames([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") uriOrMap)
    Returns a list of database names. URI is a database URI as described in the [`connect(java.lang.Object)`](#connect(java.lang.Object)) documentation, but with a '\*' where the database name would be. For instance:
    ``` datomic-plain-fence
       datomic:dev://{transactor-host}:{port}/*
     
    ```

    When using the map form, :db-name should be omitted.
    Parameters:  
    `uriOrMap` - same as in \#connect(Object), with a '\*' where the database name would be, or omitted in the map form.

    Returns:  
    List of database names.

    Since:  
    0.9.5040

  - <a id="listBackups(java.lang.String)"></a>

    <a id="listbackups"></a>

    ### listBackups

    public static [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\<[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang"),[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")\> listBackups([String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") backupUri)
    Lists all points in time available at the given `backup-uri`. Returns a map with `:backups`, sorted descending by `t`.
    Each backup contains:  
    `:t` the basis `t` of the backup  
    `:connect-uri` a URI that can be passed to `d/connect`

    Parameters:  
    `backupUri` - String

    Returns:  
    Map of backup information.

  - <a id="administerSystem(java.util.Map)"></a>

    <a id="administersystem"></a>

    ### administerSystem

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") administerSystem([Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") options)
    Administer a Datomic system. Throws if operation fails.
    Parameters:  
    `options` - Map

    Returns:  
    data describing the operation result

    Since:  
    0.9.5893

  - <a id="squuid()"></a>

    <a id="squuid"></a>

    ### squuid

    public static [UUID](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html "class or interface in java.util") squuid()
    Constructs a semi-sequential UUID. Useful for creating UUIDs that don't fragment indexes.
    Returns:  
    a UUID whose most significant 32 bits are currentTimeMillis rounded to seconds

    Since:  
    0.8.3343

  - <a id="squuidTimeMillis(java.util.UUID)"></a>

    <a id="squuidtimemillis"></a>

    ### squuidTimeMillis

    public static long squuidTimeMillis([UUID](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/UUID.html "class or interface in java.util") squuid)
    Get the time component of a squuid.
    Parameters:  
    `squuid` - a UUID created by squuid()

    Returns:  
    the time in the format of System.currentTimeMillis

    Since:  
    0.8.3343

  - <a id="tempid(java.lang.Object)"></a>

    <a id="tempid"></a>

    ### tempid

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tempid([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") partition)
    Generates a temp id in the designated partition.
    Parameters:  
    `partition` - a keyword identifying the partition.

    Returns:  
    a temp id

  - <a id="tempid(java.lang.Object,long)"></a>

    <a id="tempid-2"></a>

    ### tempid

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tempid([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") partition, long idNumber)
    Generates a temp id in the designated partition. Values of idNumber from -1 (inclusive) to -1000000 (exclusive) are reserved for user-created temp ids.
    Parameters:  
    `partition` - - a keyword identifying the partition.

    `idNumber` - - a long in the range (-1000000,-1\]

    Returns:  
    a temp id

  - <a id="toT(java.lang.Object)"></a>

    <a id="tot"></a>

    ### toT

    public static long toT([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tx)
    Returns the t value associated with this tx.
    Parameters:  
    `tx` - a tx

    Returns:  
    a t value

    Since:  
    0.8.3372

  - <a id="toTx(long)"></a>

    <a id="totx"></a>

    ### toTx

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") toTx(long t)
    Returns the tx associated with this t value.
    Parameters:  
    `t` - a t value

    Returns:  
    a tx

    Since:  
    0.8.3372

  - <a id="part(java.lang.Object)"></a>

    <a id="part"></a>

    ### part

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") part([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") entityId)
    Returns the partition of this [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities).
    Parameters:  
    `entityId` - an entityId

    Returns:  
    a partition

    Since:  
    0.8.3372

  - <a id="q(java.lang.Object,java.lang.Object...)"></a>

    <a id="q"></a>

    ### q

    public static [Collection](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Collection.html "class or interface in java.util")\<[List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")\<[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")\>\> q([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") query, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... inputs)
    Like [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...)), but with a more specific return signature. Supports same [grammar](../../../../06-reference/03-query-and-pull/query-and-pull.md) as query, except for `find-coll`, `find-scalar`, and `find-tuple`.

  - <a id="query(java.lang.Object,java.lang.Object...)"></a>

    <a id="query"></a>

    ### query

    public static \<T\> T query([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") query, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... inputs)
    Executes a [datalog query](../../../../06-reference/03-query-and-pull/query-and-pull.md).
    In addition to basic pattern matching, query supports

    - joins
    - rules
    - arbitrary predicates and functions
    - aggregates
    - binding options for inputs
    - find specification for outputs
    - pull patterns

    Query can be applied to multiple inputs, including both databases and plain old data. See the [grammar](../../../../06-reference/03-query-and-pull/query-and-pull.md) and [documentation](../../../../06-reference/03-query-and-pull/query-and-pull.md) for complete details.

    Query runs locally in a Peer process. Query is set-based: intermediate and final result sets must fit in memory. The `query` data structure passed in can be one of

    - a map that may include `:find`, `:with`, `:in`, and `:where` keys
    - a list representation of that same map
    - a serialized [edn](https://github.com/edn-format/edn) string of the list or map form

    The `inputs` can be any of

    - database values
    - arbitrary values
    - rules
    - pull patterns

    If a single database value is provided as input, then no `:in` section is required in the `query`.

    Type Parameters:  
    `T` - a type compatible with the [find specification](../../../../06-reference/03-query-and-pull/query-and-pull.md)

    Parameters:  
    `query` - a data structure describing the query

    `inputs` - inputs bound to the names in `:in` section of `query`

    Returns:  
    a data structure based on the find specification

    Since:  
    0.9.5040

  - <a id="query(datomic.QueryRequest)"></a>

    <a id="query-2"></a>

    ### query

    public static \<T\> T query([QueryRequest](../query-request/query-request.md "class in datomic") queryRequest)
    Like [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...)), but accepts a [`QueryRequest`](../query-request/query-request.md "class in datomic") object.
    Since:  
    0.9.5153

  - <a id="qseq(java.lang.Object,java.lang.Object...)"></a>

    <a id="qseq"></a>

    ### qseq

    public static [Stream](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream")\<[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")\> qseq([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") query, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... inputs)
    Performs the query described by `query` and `inputs` (as per [`query(Object, Object...)`](#query(java.lang.Object,java.lang.Object...))), Item transformations such as pull are deferred until the Stream is consumed. For queries with pull(s), this results in: ​
    - reduced memory use and the ability to execute larger queries
    - lower latency before the first results are returned

    Parameters:  
    `query` - a data structure describing the query

    `inputs` - inputs bound to the names in `:in` section of `query`

    Returns:  
    a [`Stream`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream") of the data structure based on the find specification

    Since:  
    0.9.6110

  - <a id="function(java.util.Map)"></a>

    <a id="function"></a>

    ### function

    public static datomic.functions.Fn function([Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") m)
    Generates a function object given a map of :lang - clojure or java :params - a list of parameter names used in the code :code - a string containing the code of the function body. :code should be the body of a method corresponding to the params, which will be Objects, but can begin with one or more import statements.
    Parameters:  
    `m` - a map defining the function

    Returns:  
    a function object implementing Fn plus one of FnN corresponding to its arity.

  - <a id="resolveTempid(datomic.Database,java.lang.Object,java.lang.Object)"></a>

    <a id="resolvetempid"></a>

    ### resolveTempid

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") resolveTempid([Database](../../interfaces/database/database.md "interface in datomic") db, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tempids, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tempid)
    Resolve a tempid to the actual id assigned in a database.
    Parameters:  
    `db` - a database

    `tempids` - `Connection.TEMPIDS` member of a map returned from [`Connection.transact(java.util.List)`](../../interfaces/connection/connection.md#transact(java.util.List)) or `Connection.transactAsync`.

    `tempid` - a tempid

    Returns:  
    the actual id corresponding to tempid

  - <a id="shutdown(boolean)"></a>

    <a id="shutdown"></a>

    ### shutdown

    public static void shutdown(boolean shutdownClojure)
    Shutdown all peer resources. This method should be called as part of clean shutdown of a JVM process. Will release all Connections, and, if shutdownClojure is true, will release Clojure resources. Programs written in Clojure can set shutdownClojure to false if they manage Clojure resources (e.g. agents) outside of Datomic; programs written in other JVM languages should typically set shutdownClojure to true.
    Parameters:  
    `shutdownClojure` - set true to shutdown Clojure resources

    Since:  
    0.8.3861

  - <a id="cancel(java.lang.Object)"></a>

    <a id="cancel"></a>

    ### cancel

    public static void cancel([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") anomaly)
    Cancels the current Datomic operation (query or transaction). ​ Throws an ex-info with an anomaly to the original caller. anomaly is as described by https://github.com/cognitect-labs/anomalies. ​ :cognitect.anomalies/category is a required key, valid values are: :cognitect.anomalies/incorrect :cognitect.anomalies/conflict When :cognitect.anomalies/message is provided, the message will be used as the Exception's detail message Other keys should be namespace-qualified. All data passed to cancel must be fressian-serializable.
    Parameters:  
    `anomaly` - Map
