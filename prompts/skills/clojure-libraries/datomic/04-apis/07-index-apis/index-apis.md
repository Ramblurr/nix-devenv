<a id="content"></a>

<a id="index-apis"></a>

# Index APIs

Most Datomic programs will not access the [indexes](../../06-reference/04-indexes/01-index-model/index-model.md) directly, instead taking advantage of Datomic's declarative [Datalog](../../06-reference/10-datomic-fundamentals/02-datomic-data-model/datomic-data-model.md) query engine.

However, raw index access is available for integrations. For example, you might use the indexes to make Datomic data available to a map/reduce framework spanning multiple data sources of different types.

Datomic indexes are covering indexes. This means the index actually contains the datoms, rather than just a pointer to them. When you (or a Datomic query) iterates an index, it gets the datoms themselves, without any additional lookup.

<a id="outline-container-datoms"></a>

<a id="datoms"></a>

## Datoms API

<a id="text-datoms"></a>

[Peer API](../01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/datoms) \| [Client API](../03-client-api-clojuredoc/client-api-clojuredoc.md#var-datoms)

The Datoms API lets you specify a Datomic index, plus a vector of values in the same order as the index. The [example](https://github.com/cognitect-labs/day-of-datomic-cloud/blob/master/doc-examples/raw_index_access.repl) excerpted below searches the `:avet` index for datoms whose `a` component is `:inv/sku`

``` clojure
;; Peer API
(->> (d/datoms db :avet :inv/sku)
     (take 3)
     (map :v))

;; Client API
(->> (d/datoms db
               {:index :avet
                :components [:inv/sku]})
     (take 3)
     (map :v))
```

``` clojure
=> ("SKU-0" "SKU-1" "SKU-10")
```

<a id="outline-container-index-range"></a>

<a id="index-range"></a>

## Index-range API

<a id="text-index-range"></a>

[Peer API](../01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/index-range) \| [Client API](../03-client-api-clojuredoc/client-api-clojuredoc.md#var-index-range)

The index-range API lets you specify an attribute, and returns all datoms sorted by that attribute, optionally limited by start and end values. The [example](https://github.com/cognitect-labs/day-of-datomic-cloud/blob/master/doc-examples/raw_index_access.repl) excerpted below returns all the SKUs between "SKU-42" inclusive and "SKU-44" exclusive.

``` clojure
;; Peer API
(->> (d/index-range db :inv/sku "SKU-42" "SKU-44")
     (map :v))

;; Client API
(->> (d/index-range
      db
      {:attrid :inv/sku
       :start "SKU-42"
       :end "SKU-44"})
     (map :v))
```

``` clojure
=> ("SKU-42" "SKU-43")
```
