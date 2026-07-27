<a id="content"></a>

<a id="system-properties"></a>

# System Properties

Datomic's Java system properties are all named via the convention *datomic.somePropertyName*.

Memory settings can be specified in plain bytes, or use k / m / g suffixes for kilobytes / megabytes / gigabytes, e.g. *256m*.

Example property files are in the config/samples directory of the Datomic distribution.

<a id="outline-container-reading-properties-file"></a>

<a id="reading-properties-file"></a>

## Reading Properties Files

<a id="text-reading-properties-file"></a>

Each property has a comment describing its use, plus one or more of the tags below:

| Property tag | Meaning                                           |
|--------------|---------------------------------------------------|
| Required     | No reasonable default, you must set this property |
| Defaulted    | Setup will default this property for you          |
| Generated    | Setup will generate a unique value for you        |
| Optional     | Property is not required                          |

<a id="outline-container-peer-properties"></a>

<a id="peer-properties"></a>

### Peer Properties

<a id="text-peer-properties"></a>

Datomic Peer properties should be set using command line arguments, for example:

``` sh
-Ddatomic.txTimeoutMsec=60000
```

| Property | Use | Units | Default |
|----|----|----|----|
| [datomic.ddbRequestTimeout](../01-storage-services/storage-services.md#other-aws-configuration) | Amount of time a DDB request must complete before timing out | Integer milliseconds | 1000 |
| datomic.memcachedExpirationDays | Please contact [support](mailto:support@cognitect.com) before attempting to use this setting | Integer | 30 |
| [datomic.memcachedPassword](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached password | String | {None} |
| [datomic.memcachedServers](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached server list | host:port(,host:port)\* | {None} |
| [datomic.memcachedUsername](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached username | String | {None} |
| [datomic.memcachedAutoDiscovery](../09-memory-and-caching/memory-and-caching.md#node-auto-discovery) | Auto discovery of Memcached nodes | Boolean | False |
| [datomic.memcachedConfigTimeoutMsec](../09-memory-and-caching/memory-and-caching.md#node-auto-discovery) | Timeout for Elasticache auto-discovery | Integer milliseconds | 100 |
| [datomic.objectCacheMax](../09-memory-and-caching/memory-and-caching.md#object-cache) | Size of object cache | Bytes | 50% of VM RAM, min 32m |
| datomic.readConcurrency | Soft limit on concurrent storage reads | Integer | 2x write concurrency |
| [datomic.txTimeoutMsec](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/transact) | Timeout for transact | Integer milliseconds | 10000 |
| datomic.metricsCallback | [Callback](../06-monitoring-and-performance/monitoring-and-performance.md#custom) for reporting peer metrics | String | {none} |
| datomic.valcachePath | Valcache [SSD directory](../13-valcache/valcache.md#prerequisites) | String | {None} |
| datomic.valcacheMaxGb | Maximum GB Valcache will try to use | Gigabytes | {None} |
| datomic.prefetchConcurrency | Limit on concurrent reads supporting datomic.api/with | Integer | half of available CPUs |
| datomic.prefetchProbes | Whether to prefetch reads supporting datomic.api/with | Boolean | true when \>= 2 CPUs |

<a id="outline-container-transactor-properties"></a>

<a id="transactor-properties"></a>

### Transactor Properties

<a id="text-transactor-properties"></a>

The equivalent names in the transactor properties file have no namespace, and are hyphen delimited lowercase, e.g. *some-property-name*. The exception to this rule is the transactor property corresponding to `datomic.memcachedServers`, which is called `memcached`.

The `transactor` script provided with Datomic expects the properties file to be the last argument.

Note that JVM args other than `-Xmx` and `-Xms` passed to `bin/transactor` (including Java system properties passed via `-D`) override Datomic's default Java options, including the GC settings.

| System property | Use | Units | Default | Where to set |
|----|----|----|----|----|
| [datomic.cassandraClusterCallback](../01-storage-services/storage-services.md) | Name of a callback method/fn returning a [Cluster](https://docs.datastax.com/en/drivers/java/2.0/com/datastax/driver/core/Cluster.html) | String | {None} | Transactor properties file |
| [datomic.ddbRequestTimeout](../01-storage-services/storage-services.md#other-aws-configuration) | Amount of time a DDB request must complete before timing out | Integer milliseconds | 1000 | Command line arg |
| [datomic.heartbeatIntervalMsec](../07-high-availability/high-availability.md) | Interval between heartbeat write to storage | Integer milliseconds | 5000, min 1000 |   |
| datomic.licenseKey | Transactor license key | String | {None} | Transactor properties file |
| [datomic.memcachedPassword](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached password | String | {None} | Transactor properties file |
| [datomic.memcachedServers](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached server list | host:port (,host:port)\* | {None} | Transactor properties file |
| [datomic.memcachedUsername](../09-memory-and-caching/memory-and-caching.md#memcached) | Memcached username | String | {None} | Transactor properties file |
| [datomic.memcachedAutoDiscovery](../09-memory-and-caching/memory-and-caching.md#node-auto-discovery) | Auto discovery of memcached nodes | Boolean | False | Command line arg or transactor properties file |
| [datomic.memcachedConfigTimeoutMsec](../09-memory-and-caching/memory-and-caching.md#node-auto-discovery) | Timeout for Elasticache auto-discovery | Integer milliseconds | 100 | Command line arg or transactor properties file |
| [datomic.memoryIndexThreshold](../05-capacity-planning/capacity-planning.md) | Size that kicks off indexing job | Bytes | {see [recommendations](../05-capacity-planning/capacity-planning.md#memory-index-defaults)} | transactor properties file |
| [datomic.memoryIndexMax](../05-capacity-planning/capacity-planning.md) | Transactions throttle to let index job catch up | Bytes | {See [recommendations](../05-capacity-planning/capacity-planning.md#memory-index-defaults)} | Transactor properties file |
| [datomic.gcStoragePaceMsec](../05-capacity-planning/capacity-planning.md#garbage-collection-deleted-production) | Paces gc-storage delete operations | Integer (msec) | 0 | Command line arg |
| [datomic.metricsCallback](../06-monitoring-and-performance/monitoring-and-performance.md) | The name of a static Java method or Clojure fn | String | RAM | Transactor properties file |
| [datomic.objectCacheMax](../09-memory-and-caching/memory-and-caching.md#object-cache) | Size of object cache | Bytes | 50% of VM RAM, min 32mb | Transactor properties file |
| datomic.pidFile | Write pid to this file on startup | Filename | {None} | Transactor properties file |
| datomic.printConnectionInfo | Print connection info at startup | Boolean | False | Command line arg |
| datomic.sqlUser | Username for SQL storage | String | {None} | Command line arg or transactor properties file |
| datomic.sqlPassword | Password for SQL storage | String | {None} | Command line arg or transactor properties file |
| [datomic.sqlValidationQuery](../01-storage-services/storage-services.md#validation-query) | Query used to validate JDBC connections | String | {See [storage docs](../01-storage-services/storage-services.md#validation-query)} | Transactor properties file |
| datomic.readConcurrency | Soft limit on concurrent storage reads | Integer | 2x write concurrency | Transactor properties file |
| datomic.writeConcurrency | Soft limit on concurrent storage writes | Integer | 4 | Transactor properties file |
| datomic.prefetchConcurrency | Limit on concurrent transaction-supporting reads | Integer | half of available CPUs | Command line arg or transactor properties file |
| datomic.prefetchProbes | Whether to prefetch transaction-supporting reads | Boolean | true when \>= 2 CPUs | Command line arg or transactor properties file |

<a id="outline-container-backup-properties"></a>

<a id="backup-properties"></a>

### Backup Properties

<a id="text-backup-properties"></a>

| Property | Use | Units | Default |
|----|----|----|----|
| [datomic.backupPaceMsec](../08-backup-and-restore/backup-and-restore.md#performance) | Interval to pause between backup writes | Integer milliseconds | {None} |
| [datomic.fileBackupConcurrency](../08-backup-and-restore/backup-and-restore.md#performance) | Number of threads used for file backup/restore | Integer | 5 |
| [datomic.s3BackupConcurrency](../08-backup-and-restore/backup-and-restore.md#performance) | Number of threads used for s3 backup/restore | Integer | 25 |

Note that:

- `backupPaceMsec` can reduce I/O pressure by slowing the pace of backups.
- `datomic.fileBackupConcurrency` affects the number of concurrent read/writes on local storage.
- `datomic.s3BackupConcurrency` affects the number of concurrent read/writes when backing up to S3.

<a id="outline-container-properties-changes"></a>

<a id="properties-changes"></a>

### Properties Changes

<a id="text-properties-changes"></a>

- In 0.8.3814, *datomic.objectCacheBytes* was deprecated, and renamed to *datomic.objectCacheMax*.
- In 0.8.4110, the defaults for *datomic.objectCacheMax*, *datomic.memoryIndexThreshold*, and *datomic.memoryIndexMax* were removed on the transactor, so that the transactor properties file must now specify values for these properties. Peer defaults remain as described above.
- datomic.licenseKey is valid only for [Datomic 1.0.6711](../../../11-releases/01-datomic-pro/02-pro-change-log/pro-change-log.md#1.0.6711) version or older.
