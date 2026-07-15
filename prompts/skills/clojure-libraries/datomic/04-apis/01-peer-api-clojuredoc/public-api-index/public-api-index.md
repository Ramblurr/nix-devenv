<a id="content_view"></a>

<a id="right-sidebar"></a>

<a id="content-tag"></a>

<a id="overview"></a>

# Index of Public Functions and Variables - <a id="header-project"></a>Datomic Clojure <a id="header-version"></a>

This page has an alphabetical index of all the documented functions and variables in Datomic Clojure.

Shortcuts:  
[A](#A) [B](#B) [C](#C) [D](#D) [E](#E) [F](#F) [G](#G) [H](#H) [I](#I) [J](#J) [K](#K) [L](#L) [M](#M)  
[N](#N) [O](#O) [P](#P) [Q](#Q) [R](#R) [S](#S) [T](#T) [U](#U) [V](#V) [W](#W) [X](#X) [Y](#Y) [Z](#Z)  
[Other](#Other)  
<a id="index-body"></a>

<a id="A"></a>

## <a id="section-head"></a>A

```
 add-listener                 function      datomic.api        Register a completion listener for the future. The...
 administer-system            function      datomic.api        Administer system. Takes an options map with a req...
 as-of                        function      datomic.api        Returns the value of the database as of some point...
 as-of-t                      function      datomic.api        Returns the as-of point, or nil if none.
 attribute                    function      datomic.api        Returns information about the attribute with the g...

  
```

<a id="index-body"></a>

<a id="B"></a>

## <a id="section-head"></a>B

```
 basis-t                      function      datomic.api        Returns the t of the most recent transaction reach...

  
```

<a id="index-body"></a>

<a id="C"></a>

## <a id="section-head"></a>C

```
 cancel                       function      datomic.api        Cancels the current Datomic operation (query or tr...
 connect                      function      datomic.api        Connects to the specified database, returning a Co...
 create-database              function      datomic.api        Creates database specified by uri. Returns true if...

  
```

<a id="index-body"></a>

<a id="D"></a>

## <a id="section-head"></a>D

```
 datoms                       function      datomic.api        Raw access to the index data, by index. The index ...
 db                           function      datomic.api        Retrieves a value of the database for reading. Doe...
 db-stats                     function      datomic.api        Queries for database stats. Returns a map includin...
 delete-database              function      datomic.api        Deletes the database specified by uri. Returns tru...

  
```

<a id="index-body"></a>

<a id="E"></a>

## <a id="section-head"></a>E

```
 entid                        function      datomic.api        Returns the entity id associated with a symbolic k...
 entid-at                     function      datomic.api        Returns a fabricated entity id in the supplied par...
 entity                       function      datomic.api        Returns a dynamic map of the entity's attributes f...
 entity-db                    function      datomic.api        Returns the database value that is the basis for t...

  
```

<a id="index-body"></a>

<a id="F"></a>

## <a id="section-head"></a>F

```
 filter                       function      datomic.api        Returns the value of the database containing only ...
 function                     function      datomic.api        Generates a function object given a map with requi...

  
```

<a id="index-body"></a>

<a id="G"></a>

## <a id="section-head"></a>G

```
 gc-storage                   function      datomic.api        Allow storage to reclaim garbage older than a cert...
 get-database-names           function      datomic.api        Returns a list of database names. URI is a databas...

  
```

<a id="index-body"></a>

<a id="H"></a>

## <a id="section-head"></a>H

```
 history                      function      datomic.api        Returns a special database containing all assertio...

  
```

<a id="index-body"></a>

<a id="I"></a>

## <a id="section-head"></a>I

```
 ident                        function      datomic.api        Returns the keyword associated with an id, or the ...
 implicit-part                function      datomic.api        Returns the implicit partition (an entity id) corr...
 implicit-part-id             function      datomic.api        Returns the id of the given implicit partition, wh...
 index-pull                   function      datomic.api        Walks an index, pulling entities via :e if :avet o...
 index-range                  function      datomic.api        Returns an Iterable range of datoms in index named...
 invoke                       function      datomic.api        Lookup the database function named by eid-or-ident...
 is-filtered                  function      datomic.api        Returns true if db has had a filter set with filte...

  
```

<a id="index-body"></a>

<a id="J"></a>

## <a id="section-head"></a>J

```

  
```

<a id="index-body"></a>

<a id="K"></a>

## <a id="section-head"></a>K

```

  
```

<a id="index-body"></a>

<a id="L"></a>

## <a id="section-head"></a>L

```
 list-backups                 function      datomic.api        Lists all points in time available at the given ba...
 log                          function      datomic.api        Retrieves a value of the log for use in tx-range o...

  
```

<a id="index-body"></a>

<a id="M"></a>

## <a id="section-head"></a>M

```

  
```

<a id="index-body"></a>

<a id="N"></a>

## <a id="section-head"></a>N

```
 next-t                       function      datomic.api        Returns the t one beyond the highest reachable via...

  
```

<a id="index-body"></a>

<a id="O"></a>

## <a id="section-head"></a>O

```

  
```

<a id="index-body"></a>

<a id="P"></a>

## <a id="section-head"></a>P

```
 part                         function      datomic.api        Return the partition associated with an entity id..
 pull                         function      datomic.api        Like pull-many, but takes a single eid..
 pull-many                    function      datomic.api        Returns hierarchical selections of attributes for ...

  
```

<a id="index-body"></a>

<a id="Q"></a>

## <a id="section-head"></a>Q

```
 q                            function      datomic.api        Executes a query against inputs.  Inputs are data...
 qseq                         function      datomic.api        Performs the query described by query-map (as per ...
 query                        function      datomic.api        Executes the query described by query-map  query-m...

  
```

<a id="index-body"></a>

<a id="R"></a>

## <a id="section-head"></a>R

```
 release                      function      datomic.api        Request the release of resources associated with t...
 remove-tx-report-queue       function      datomic.api        Removes the queue associated with this connection..
 rename-database              function      datomic.api        Renames the database specified by uri to new-name....
 request-index                function      datomic.api        Schedules a re-index of the database. The re-index...
 resolve-tempid               function      datomic.api        Resolve a tempid to the actual id assigned in a da...
 rseek-datoms                 function      datomic.api        Like seek-datoms, but iterates the index in revers...

  
```

<a id="index-body"></a>

<a id="S"></a>

## <a id="section-head"></a>S

```
 seek-datoms                  function      datomic.api        Raw access to the index data, by index. The index ...
 shutdown                     function      datomic.api        Shutdown all peer resources.  This method should b...
 since                        function      datomic.api        Returns the value of the database since some point...
 since-t                      function      datomic.api        Returns the since point, or nil if none.
 squuid                       function      datomic.api        Constructs a semi-sequential UUID. Useful for crea...
 squuid-time-millis           function      datomic.api        get the time part of a squuid (a UUID created by s...
 sync                         function      datomic.api        Used to coordinate with other peers.  When called ...
 sync-excise                  function      datomic.api        Used to coordinate with background excision. Retur...
 sync-index                   function      datomic.api        Used to coordinate with background indexing jobs. ...
 sync-schema                  function      datomic.api        Used to coordinate with background schema changes....

  
```

<a id="index-body"></a>

<a id="T"></a>

## <a id="section-head"></a>T

```
 t->tx                        function      datomic.api        Return the transaction id associated with a t valu...
 tempid                       function      datomic.api        Generate a tempid in the specified partition. With...
 touch                        function      datomic.api        Touches all of the attributes of the entity, inclu...
 transact                     function      datomic.api        Given a connection and a set of information (tx-da...
 transact-async               function      datomic.api        Same as transact, but returns its future immediate...
 tx->t                        function      datomic.api        Return the t value associated with a transaction i...
 tx-range                     function      datomic.api        Returns a range of transactions in log, starting a...
 tx-report-queue              function      datomic.api        Gets the data queue associated with this connectio...

  
```

<a id="index-body"></a>

<a id="U"></a>

## <a id="section-head"></a>U

```

  
```

<a id="index-body"></a>

<a id="V"></a>

## <a id="section-head"></a>V

```

  
```

<a id="index-body"></a>

<a id="W"></a>

## <a id="section-head"></a>W

```
 with                         function      datomic.api        d/with is a pure function that takes a database va...

  
```

<a id="index-body"></a>

<a id="X"></a>

## <a id="section-head"></a>X

```

  
```

<a id="index-body"></a>

<a id="Y"></a>

## <a id="section-head"></a>Y

```

  
```

<a id="index-body"></a>

<a id="Z"></a>

## <a id="section-head"></a>Z

```

  
```

<a id="index-body"></a>

<a id="Other"></a>

## <a id="section-head"></a>Other

```

  
```
