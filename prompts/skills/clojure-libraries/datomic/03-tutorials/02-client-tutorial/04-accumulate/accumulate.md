<a id="content"></a>

<a id="accumulate"></a>

# Accumulate

<a id="outline-container-more-schema"></a>

<a id="more-schema"></a>

## More Schema

<a id="text-more-schema"></a>

Our stakeholders have a new request. Now it isn't just an inventory database, it also needs to track orders:

- An order is a collection of line items
- Each line item has a count and references an item in the inventory

We can model this directly in Datomic schema without translation:

noslide

``` clojure
(def order-schema
  [{:db/ident :order/items
    :db/valueType :db.type/ref
    :db/cardinality :db.cardinality/many
    :db/isComponent true}
   {:db/ident :item/id
    :db/valueType :db.type/ref
    :db/cardinality :db.cardinality/one}
   {:db/ident :item/count
    :db/valueType :db.type/long
    :db/cardinality :db.cardinality/one}])

(d/transact conn {:tx-data order-schema})
```

``` clojure
=> ;; transaction result map
```

Note that:

- `:db.cardinality/many` allows a single order to have multiple `:order/items`
- `:db/isComponent` `true` tells Datomic that order items belong to an order

<a id="outline-container-more-data"></a>

<a id="more-data"></a>

## More Data

<a id="text-more-data"></a>

Now let's add a sample order:

noslide

``` clojure
(def add-order
  {:order/items
   [{:item/id [:inv/sku "SKU-25"]
     :item/count 10}
    {:item/id [:inv/sku "SKU-26"]
     :item/count 20}]})

(d/transact conn {:tx-data [add-order]})
```

``` clojure
result ;; tx result map
```

In this example a **nested** entity map is displayed. The top level is the order, which has multiple `:order/items` nested within.

With this data in hand, let's explore some [more features of query](../05-read-revisited/read-revisited.md).
