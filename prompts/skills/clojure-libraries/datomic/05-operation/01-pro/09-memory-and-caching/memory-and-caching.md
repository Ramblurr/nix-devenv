<a id="content"></a>

<a id="memory-and-caching"></a>

# Memory and Caching

Datomic provides a number of caches, all of which are transparent to application code:

- [Memory index](#memory-index)
- [Entity caching](#entity-caching)
- [Object cache](#object-cache)
- [Memcached](#memcached)
- [Valcache](../13-valcache/valcache.md)

Datomic caches only immutable data, so all caches are valid forever.

<a id="outline-container-memory-index"></a>

<a id="memory-index"></a>

## Memory Index

<a id="text-memory-index"></a>

Recent datoms are cached in the memory index on the transactor and on all peers. The memory index size is [controlled](../05-capacity-planning/capacity-planning.md#memory-index-defaults) by the *memory-index-threshold* and *memory-index-max* [settings on the transactor](../11-system-properties/system-properties.md#transactor-properties). The actual size of the memory index will rarely rise much above *memory-index-threshold*, except during data imports when it may reach *memory-index-max*.

Setting memory index configuration on a peer is meaningless; peers must be able to handle the memory index given to them by the transactor.

The memory index is managed as follows:

<a id="outline-container-on-the-transactor"></a>

<a id="on-the-transactor"></a>

### On the Transactor

<a id="text-on-the-transactor"></a>

- The transactor builds the memory index from the log before it begins serving the database.
- The transactor updates the memory index after it writes a transaction to the log.
- When an indexing job is completed, the transactor drops the portion of the memory index that is no longer needed, as it is now in the durable index.

<a id="outline-container-on-the-peer"></a>

<a id="on-the-peer"></a>

### On the Peer

<a id="text-on-the-peer"></a>

- A peer builds the memory index from the log before the call to connect returns.
- A peer updates the memory index when notified by the transactor of a transaction.
- A peer drops the portion of the memory index that is no longer needed when notified by the transactor that an index job has been completed.

<a id="outline-container-entity-caching"></a>

<a id="entity-caching"></a>

## Entity Caching

<a id="text-entity-caching"></a>

Data retrieved via get (and touch) on the [Entity API](../../../06-reference/07-entities/entities.md) is cached for the lifetime of the *Entity* instance.

<a id="outline-container-object-cache"></a>

<a id="object-cache"></a>

## Object Cache

<a id="text-object-cache"></a>

Datomic processes maintain an LRU Java object cache that contains segments of [index](../../../06-reference/04-indexes/01-index-model/index-model.md) or [log](../../../04-apis/09-log-api/additional-log-api/additional-log-api.md), typically a few thousand datoms per segment. When a Datomic process needs data, Datomic looks in the object cache first. If the data is unavailable locally, Datomic reads the data from Memcached or storage and then stores the data in the cache.

The object cache size is limited by the *object-cache-max* property on the transactor and by the *datomic.ObjectCacheMax* Java system property on the peer.

Unlike the memory index, the object cache can vary (in both configuration and contents) across the different processes in a Datomic system. Because each process maintains its own cache, it will automatically adjust over time to its workload.

<a id="outline-container-memcached"></a>

<a id="memcached"></a>

## Memcached

<a id="text-memcached"></a>

Memcached is an optional addition to a Datomic system, providing another level of cache between the in-process object cache and storage. Adding Memcached to a system can reduce the load on storage, and can reduce the latency associated with populating the object cache.

Memcached configuration is [controlled](../../../02-accessing/01-peer-library/peer-library.md) by the *memcached* [property on the transactor](../11-system-properties/system-properties.md#transactor-properties) and the *datomic.memcachedServers* [Java system property on the peer](../11-system-properties/system-properties.md#peer-properties).

You can set up more than one Memcached, and each Datomic process can choose via configuration which one(s) it uses. Datomic uses only UUIDs for Memcached keys, so Datomic can coexist with other uses of a Memcached installation. Additionally, if you specify more than one Memcached server, Datomic will distribute values across all instances, effectively enabling a single cache the size of the sum of all the instances.

When configured to use Memcached, a Datomic process will automatically write into Memcached any segment it needs that is not already present in Memcached. In addition, the transactor (only) will write index and log segments to Memcached as the segments are produced.

The *datomic.memcachedServers* property specifies a fixed list of Memcached servers. To change the list of servers, you must change the value of this property and restart the affected peer and transactor processes. If you are using Amazon ElastiCache, a better approach is to use [automatic discovery](#node-auto-discovery).

<a id="outline-container-sasl-auth"></a>

<a id="sasl-auth"></a>

### SASL Auth

<a id="text-sasl-auth"></a>

Datomic supports SASL authentication to a Memcached cluster. If *datomic.memcachedUsername* and *datomic.memcachedPassword* (memcached-username and memcached-password in transactor properties) are set, Datomic will use those credentials to authenticate its connection to Memcached.

<a id="outline-container-cloud-watch"></a>

<a id="cloud-watch"></a>

### CloudWatch metrics

<a id="text-cloud-watch"></a>

If you are using Cloudwatch to [monitor transactors](../06-monitoring-and-performance/monitoring-and-performance.md), Datomic records the following Memcached metrics:

- *Memcache* is the number of read requests to Memcached
- When reading from storage, *ReaderMemcachedPutMusec* is the latency for successful writes to Memcached and *ReaderMemcachedPutFailedMusec* is the latency for failed writes
- When writing to storage, *WriterMemcachedPutMusec* is the latency for successful writes to Memcached and *WriterMemcachedPutFailedMuSec* is the latency for failed writes

<a id="outline-container-node-auto-discovery"></a>

<a id="node-auto-discovery"></a>

### Automatic Node Discovery

<a id="text-node-auto-discovery"></a>

If you are using Amazon ElastiCache, you can take advantage of [automatic discovery](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/AutoDiscovery.html) of cache nodes. Set the *memcached* property (in transactors) or *datomic.memcachedServers* property (in peers) to the [Memcached cluster's configuration endpoint](https://docs.aws.amazon.com/AmazonElastiCache/latest/mem-ug/Endpoints.html) and enable automatic discovery by setting the *datomic.memcachedAutoDiscovery* parameter to *true*.

When automatic discovery is enabled, any changes made to the cluster (such as adding or removing a node) are going to be noticed by Datomic without the need for configuration changes or any kind of intervention. The system will automatically take advantage of new nodes and stop using removed nodes as soon as the changes are observed.

Automatic discovery of Memcached nodes requires Datomic 1.0.6316 or later.

<a id="outline-container-usage-notes"></a>

<a id="usage-notes"></a>

## Usage Notes

<a id="text-usage-notes"></a>

- All forms of Datomic caching are transparent to application code.
- Datomic caching requires no configuration other than the overall size of the object cache. The [capacity planning](../05-capacity-planning/capacity-planning.md) docs guide setting cache sizes.
- The transactor benefits from both the object cache and Memcached in the course of ordinary transaction processing. For example, the transactor uses database indexes for both cardinality and uniqueness checks.
- Because the object cache lives in your application's address space, it competes with your application for available memory. Take this into account when planning your object cache and VM RAM settings.
- The independent configuration of the object cache and Memcached supports task-specific cache strategies. For example, a production system could have two groups of peers with different Memcached clusters, one for OLTP and one for OLAP loads. Meanwhile, a support engineer's machine could connect to the same system using its own local Memcached install.
