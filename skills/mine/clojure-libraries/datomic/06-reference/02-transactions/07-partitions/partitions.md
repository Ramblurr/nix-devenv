<a id="content"></a>

<a id="partitions"></a>

# Partitions

<a id="outline-container-partitions"></a>

<a id="partitions"></a>

## Partitions

<a id="text-partitions"></a>

Every Datomic entity is associated with a particular partition. These partitions act as a coarse-grained grouping mechanism for entities, much as file cabinets act as a coarse-grained grouping mechanism for paper files.

The partition is encoded via high bits in the entity ID. Therefore, entities in the same partition are sorted together in Datomic's two E-leading indexes, EAVT and AEVT. If the partitions align with usage patterns, this can improve performance. For example, consider a system with inventory, customers, and order partitions. A query for a particular item in inventory causes an "inventory" segment to be cached, and that segment contains a few thousand other inventory-related facts. If inventory queries tend to be followed by other inventory queries, this locality reduces the number of segments that a peer needs to cache. Conversely, if your application tends to access information about individual customers, it would be advantageous to put all of each particular customer's data in one partition and spread out your customers across thousands of [implicit partitions](#implicit-partitions).

Datomic supports two types of partitions: implicit partitions and named partitions. Both can be used in the same database.

Partitions enable two techniques that are handy in larger systems: partition sharding and new entity scans.

Partitions are strictly a locality optimization. You can ignore partitions completely; if you do, all your domain entities will be in the same (default) partition.

<a id="outline-container-implicit-partitions"></a>

<a id="implicit-partitions"></a>

## Implicit Partitions

<a id="text-implicit-partitions"></a>

Implicit partitions are currently available only in Datomic Pro Edition.

To facilitate entity grouping when using a multitude of partitions, each Datomic database includes 524288 implicit partitions, which can be accessed by calling *implicit-part*. Unlike named partitions, implicit partitions require no transaction to create. Like named partitions, each implicit partition corresponds to an entity ID.

Applications can employ algorithmic schemes to group related entities to the same partition. For example, an order processing system could assign a customer to an implicit partition (e.g. via hashing), and then put all of a customer's order and line item entities in that partition. This would improve locality of reference when querying for a customer's orders.

<a id="outline-container-named-partitions"></a>

<a id="named-partitions"></a>

## Named Partitions

<a id="text-named-partitions"></a>

Named partitions are useful when your domain has a modest number of named categories for which you would like to have locality. In addition, named partitions are used internally by Datomic. Every Datomic database comes with three named partitions:

| Partition     | Purpose                                  |
|---------------|------------------------------------------|
| :db.part/db   | System partition, used for schema        |
| :db.part/tx   | Transaction partition                    |
| :db.part/user | User partition, for application entities |

Schema entities are automatically placed in the *:db.part/db* partition.

[Transaction entities](../02-transaction-data/transaction-data.md#reified-txes) are automatically placed in the *:db.part/tx* partition.

<a id="outline-container-default-partition"></a>

<a id="default-partition"></a>

### Default Partition

<a id="text-default-partition"></a>

The *:db.part/user partition* is the default partition for entities whenever a partition is not otherwise specified. In Datomic Pro, you can override this default by setting *default-partition* in the transactor properties file:

``` clojure
default-partition=:my.namespace/my-partition
```

<a id="outline-container-creating-new-partitions"></a>

<a id="creating-new-partitions"></a>

### Installing Named Partitions

<a id="text-creating-new-partitions"></a>

To install a new named partition, transact an entity with an ident and reference that new entity as a *db.install/partition* value of the system entity *db.part/db*.

For example, the transaction data specifies a partition named *:communities*:

``` clojure
{:db/ident :communities
 :db.install/_partition :db.part/db}
```

<a id="outline-container-partition-assignment"></a>

<a id="partition-assignment"></a>

## Partition Assignment

<a id="text-partition-assignment"></a>

Partition assignment is currently available only in Datomic Pro Edition.

To control partition assignment for tempids, entity maps can include the *:db/force-partition* or *:db/match-partition* directives. These directives allow you to request partition assignment for any new entity id created by a transaction.

Because partition directives are separate maps, they encourage keeping partition policy separate from entity data, and make it easier to write supporting code that manages partitions across many transactions.

<a id="outline-container-force-partition"></a>

<a id="force-partition"></a>

### :db/force-partition

<a id="text-force-partition"></a>

The value of *:db/force-partition* is a map from tempids to desired partitions. Named partitions are specified by a keyword, such as *:orders* below:

``` clojure
[{:db/id "order"
  :order/lineItems ["item1", "item2"]
 {:db/id "item1"
  :lineItem/product chocolate
  :lineItem/quantity 1}
 {:db/id "item2"
  :lineItem/product whisky
  :lineItem/quantity 2}
  {:db/force-partition {"order" :orders
                        "item1" :orders
                        "item2" :orders}}]
```

Implicit partitions are specified by entity id, found by calling `db.part` or [implicit-part](#implicit-partitions). The example below transacts "customer" and "order" into implicit partition `343`:

``` clojure
[{:db/id "customer"
  :customer/order "order"}
 {:db/id "order"
  :order/id "55555"}
 {:db/force-partition {"customer" (d/implicit-part 343)
                       "order" (d/implicit-part 343)}}]
```

<a id="outline-container-match-partition"></a>

<a id="match-partition"></a>

### :db/match-partition

<a id="text-match-partition"></a>

Sometimes it is more convenient to request a partition via an entity in the same partition, rather than the partition id. The value of :db/match-partition is a map from tempids to *entities* in desired partitions.

The following example transacts line items into the same partition (implicit part 500) as their containing order:

``` clojure
[{:db/id "order"
  :order/lineItems ["item1", "item2"]}
 {:db/id "item1"
  :lineItem/product chocolate
  :lineItem/quantity 1}
 {:db/id "item2"
  :lineItem/product whisky
  :lineItem/quantity 2}
 {:db/force-partition {"order" (d/implicit-part 500)}
  :db/match-partition {"item1" "order"
                       "item2" "order"}}]
```

<a id="outline-container-partition-sharding"></a>

<a id="partition-sharding"></a>

## Partition Sharding

<a id="text-partition-sharding"></a>

Partition-based sharding is a technique for distributing entity-scoped read load to application servers. When dividing entities mechanically into N different groups at creation time, grouping together entities that are likely to be accessed together, it is possible to assign each group a different partition in Datomic. Then, at query time, direct entity-related queries to different application servers based on their partition. This causes the application servers to cache disjoint subsets of the total index, substantially increasing the fraction of the index that can fit into application server memory.

Partition-based sharding is an optimization only. Entities in any partition can still be reached by any peer.

<a id="outline-container-new-entity-scans"></a>

<a id="new-entity-scans"></a>

## New Entity Scans

<a id="text-new-entity-scans"></a>

Because Datomic stores information about time, it is easy to ask questions that apply only to recently created entities. For example, it is trivial in Datomic to run a batch job over everything that changed today, by grabbing the *txRange* of the [log](../../../04-apis/09-log-api/log-api.md) starting at midnight.

Such a scan does, however, have to consider *all* of today's datoms, filtering out any that are irrelevant to the task at hand.

It is possible to use partitions as a filtering mechanism when designing a system that needs to know about specific new entities (something that wants to respond to new events of a certain type, for example, using the Peer API):

- Assign all the datoms for an event category to the same partition.
- Instead of using the log, use [entid-at](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/entid-at) to fabricate an event id closest to the chosen start time t.
- Pass the fabricated entity id to [seek-datoms](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/seek-datoms) to walk EAVT, walking entities ordered by time of creation and implicitly "filtered" by partition's impact on order.

<a id="outline-container-making-temporary-ids"></a>

<a id="making-temporary-ids"></a>

## Partitions in Tempids (Obsolete)

<a id="text-making-temporary-ids"></a>

Tempid partitions are obsolete but will continue to be supported. For new applications, use [db/force-partition and db/match-partition](#partition-assignment) to assign partitions.

Datomic supports partition assignment inside tempids. Rather than tempid strings, you can create tempids as a special data structure, with a slot for specifying the desired partition.

To assign a partition to a tempid, create a structural tempid by calling [d/tempid](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/tempid), passing the partition:

``` clojure
(d/tempid :preferred-customers)
```

Each call to *tempid* produces a unique temporary id. If you want two call to *tempid* to produce the same id, pass a negative number in the range -1 .. -100000 as a second argument. All calls to *tempid* with the same second argument will return the same id.

Datomic also supports a tempid [tagged literal](https://clojure.org/reference/reader#tagged_literals):

``` clojure
#db/id[partition-name value*]
```
