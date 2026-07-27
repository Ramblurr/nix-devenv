<a id="content"></a>

<a id="datomic-pro-change-log"></a>

# Datomic Pro Change Log

<a id="outline-container-readme"></a>

<a id="readme"></a>

## Read This First

<a id="text-readme"></a>

- This document covers all releases. For a summary of critical release notices only, see [Release Notices](../03-pro-release-notices/pro-release-notices.md).
- Releases with four version number components are bugfix **only**: releases based on their three-component parents, e.g. 0.8.4020.24 is a bugfix release for 0.8.4020. When upgrading, you should always choose the highest-numbered bugfix release in a family of releases.
- The Datomic team recommends that you always test new releases in a staging environment first.
- The Datomic team recommends that you always take a backup before adopting a new release.

<a id="outline-container-1.0.7622"></a>

<a id="1.0.7622"></a>

## 1.0.7622: 2026/04/28

<a id="text-1.0.7622"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7622.zip` | 2026/04/28 | 1.0.7622 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7622/datomic-pro-1.0.7622.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7622"]` | 2026/04/28 | 1.0.7622 |  |
|  |  |  |  |

- Feature: Read-only connections to storage and backups  
  See [read only connections](../../../05-operation/01-pro/02-read-only-connections/read-only-connections.md)
- Feature: rseek-datoms - reverse index iteration, complement to seek-datoms  
  See [rseek-datoms](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/rseek-datoms)
- Performance: Reduce log write amplification for systems with many transactions
- New API: list-backups - lists the timepoints available in a backup repository  
  See [list-backups](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/list-backups)
- Performance: Reduce CPU and memory required to calculate index metrics
- Fix: Regression introduced in 1.0.7556 which broke the ddb-local protocol

<a id="outline-container-1.0.7556"></a>

<a id="1.0.7556"></a>

## 1.0.7556: 2026/03/13

<a id="text-1.0.7556"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7556.zip` | 2026/03/13 | 1.0.7556 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7556/datomic-pro-1.0.7556.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7556"]` | 2026/03/13 | 1.0.7556 |  |
|  |  |  |  |

- Fix: Prevent issue when running both io-stats and query-stats where `:ret` would nest.
- Performance: Significantly reduce CPU and memory allocation of Datomic's memory-size routine.
- Dependency upgrade: Datomic now uses AWS Java SDK v2, and has removed dependencies on v1

Peers connecting to DynamoDB storage must depend on `software.amazon.awssdk/dynamodb {:mvn/version "2.31.45"}`

Apps that use AWS SDK v1 classes `com.amazonaws.*` implicitly should make explicit their dependency on v1 libraries or migrate usages to v2.

If your application uses certain logging backends, AWS Java SDK v2 requires these minimum versions

- logback-classic -\> 1.4.14
- org.slf4j/slf4j-jdk14 -\> 1.7.36
- org.slf4j/slf4j-log4j12 -\> 1.7.36

<a id="outline-container-1.0.7491"></a>

<a id="1.0.7491"></a>

## 1.0.7491: 2026/01/26

<a id="text-1.0.7491"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7491.zip` | 2026/01/26 | 1.0.7491 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7491/datomic-pro-1.0.7491.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7491"]` | 2026/01/26 | 1.0.7491 |  |
|  |  |  |  |

- Fix: Ignore component relationships established after an excision request
- Performance: excision-repair-tool reporting and repairing performance is significantly improved.

<a id="outline-container-1.0.7482"></a>

<a id="1.0.7482"></a>

## 1.0.7482: 2026/01/06

<a id="text-1.0.7482"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7482.zip` | 2026/01/06 | 1.0.7482 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7482/datomic-pro-1.0.7482.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7482"]` | 2026/01/06 | 1.0.7482 |  |
|  |  |  |  |

- Performance: Improve indexing performance, reduce I/O in large databases

<a id="outline-container-1.0.7469"></a>

<a id="1.0.7469"></a>

## 1.0.7469: 2025/10/23

<a id="text-1.0.7469"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7469.zip` | 2025/10/23 | 1.0.7469 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7469/datomic-pro-1.0.7469.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7469"]` | 2025/10/23 | 1.0.7469 |  |
|  |  |  |  |

- Fix: Indexing slowly leaks garbage segments in storage which are unrecoverable by `gc-storage`.
- Fix: excisions may not be completely applied to [as-of](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/as-of) or [history](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/history) database values

Datomic Release 1.0.7469 fixes a bug that prevented excisions from removing datoms from the [as-of](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/as-of) or [history](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/history) indexes. This release also includes a tool to detect incomplete excisions to the index and optionally re-apply them. This bug only affects databases that contain excision datoms (`:db/excise`). This bug does not affect ordinary database values (those without [as-of](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/as-of) or [history](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/history)), nor the transaction log.

See: [Excision Repair Tool](../03-pro-release-notices/pro-release-notices.md#excision-repair-tool)

The tool works in both report and repair modes while the transactor runs. The tool needs read permissions to storage, like a peer. Repair mode requires write permissions.

<a id="outline-container-1.0.7394"></a>

<a id="1.0.7394"></a>

## 1.0.7394: 2025/08/07

<a id="text-1.0.7394"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7394.zip` | 2025/08/07 | 1.0.7394 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7394/datomic-pro-1.0.7394.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7394"]` | 2025/08/07 | 1.0.7394 |  |
|  |  |  |  |

- Fix: Prevent a problem where in rare situations indexing jobs can fail to progress indefinitely.

<a id="outline-container-1.0.7387"></a>

<a id="1.0.7387"></a>

## 1.0.7387: 2025/06/27

<a id="text-1.0.7387"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7387.zip` | 2025/06/27 | 1.0.7387 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7387/datomic-pro-1.0.7387.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7387"]` | 2025/06/27 | 1.0.7387 |  |
|  |  |  |  |

- Performance: Reduce Peer and Transactor memory usage in large databases
- Performance: Improve indexing performance, reduce I/O in large databases
- Upgraded org.clojure/core.async to 1.8.741

<a id="outline-container-1.0.7364"></a>

<a id="1.0.7364"></a>

## 1.0.7364: 2025/05/08

<a id="text-1.0.7364"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7364.zip` | 2025/05/08 | 1.0.7364 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7364/datomic-pro-1.0.7364.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7364"]` | 2025/05/08 | 1.0.7364 |  |
|  |  |  |  |

- Datomic peer library now requires Clojure 1.11.4 or greater. See: <https://forum.datomic.com/t/release-notice-datomic-pro-peer-updating-to-clojure-1-11-4/2503>
- Fix: Calling d/transact or d/transact-async with nil tx-data no longer terminates the transactor.
- Fix: memory protocol databases require an attribute be indexed when adding uniqueness constraint.
- Enhancement: Default to index-parallelism when adding an AVET index.
- Enhancement: Reduced size of Datomic zip distribution.

<a id="outline-container-1.0.7277"></a>

<a id="1.0.7277"></a>

## 1.0.7277: 2024/12/16

<a id="text-1.0.7277"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7277.zip` | 2024/12/16 | 1.0.7277 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7277/datomic-pro-1.0.7277.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7277"]` | 2024/12/16 | 1.0.7277 |  |
|  |  |  |  |

- Performance: Reduce memory required for indexing.

<a id="outline-container-1.0.7260"></a>

<a id="1.0.7260"></a>

## 1.0.7260: 2024/10/22

<a id="text-1.0.7260"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7260.zip` | 2024/10/22 | 1.0.7260 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7260/datomic-pro-1.0.7260.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7260"]` | 2024/10/22 | 1.0.7260 |  |
|  |  |  |  |

- Performance: Reduce memory required to calculate db-stats.
- Performance: Reduce memory required to calculate index-metrics.
- Feature: `datomic.api/with` now supports io-stats.
- Feature: hints. See [reducing latency with transaction hints](../../../06-reference/02-transactions/08-reducing-latency-with-transaction-hints/reducing-latency-with-transaction-hints.md)

<a id="outline-container-1.0.7187"></a>

<a id="1.0.7187"></a>

## 1.0.7187: 2024/08/22

<a id="text-1.0.7187"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7187.zip` | 2024/08/22 | 1.0.7187 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7187/datomic-pro-1.0.7187.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7187"]` | 2024/08/22 | 1.0.7187 |  |
|  |  |  |  |

- Upgraded Clojure to 1.11.4 in the transactor. See <https://clojure.org/news/2024/08/03/clojure-1-11-4>
- Performance: Reduce transactor memory usage when indexing, particularly when adding an AVET index.
- Performance: Reduce memory required by transactors and peers.

<a id="outline-container-1.0.7180"></a>

<a id="1.0.7180"></a>

## 1.0.7180: 2024/07/11

<a id="text-1.0.7180"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7180.zip` | 2024/07/11 | 1.0.7180 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7180/datomic-pro-1.0.7180.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7180"]` | 2024/07/11 | 1.0.7180 |  |
|  |  |  |  |

- Feature: tx-stats. See [tx stats](../../../04-apis/13-tx-stats/tx-stats.md)
- Feature: New Cassandra3 protocol with the V4 Datastax driver. See [cassandra](../../../05-operation/01-pro/01-storage-services/storage-services.md#cassandra)
- Performance: Improve performance in transactions and calls to `datomic.api/with` by prefetching reads. Config option datomic.prefetchConcurrency limits the number of concurrent prefetches. See [system properties](../../../05-operation/01-pro/11-system-properties/system-properties.md)
- Performance: Improved transaction performance.
- Fix: Regression introduced in 1.0.7010 where the peer jar includes compiled Clojure libraries. If your app has an existing dependency on core.async, ensure that you depend on 1.6.681 or later. An older version will cause the peer to throw a ClassCastException when connecting to a database. See the core.async changelog for more details: <https://github.com/clojure/core.async?tab=readme-ov-file#changelog>
- Fix: Regression introduced in 1.0.7010 where continuous heavy transaction load could cause unbounded memory use on the transactor.
- Fix: TransactionApplyMsec metric now includes transactions which took less than a millisecond to apply.
- Fix: Ensure datoms are virtual and are no longer added to the log.
- Upgraded Clojure to 1.11.3 in the transactor.
- Upgraded com.datomic/client-pro to 1.0.81
- Upgraded bootstrap.js in the REST API server to 5.3.3 addresses CVE-2016-10735.
- Datomic now supports Java 21.

<a id="outline-container-1.0.81"></a>

<a id="1.0.81"></a>

## 1.0.81: 2024/07/11 - Client-Pro

<a id="text-1.0.81"></a>

- Upgraded com.cognitect/transit-clj to 1.0.333
- Upgraded com.cognitect/http-client to 1.0.127

<a id="outline-container-1.0.78"></a>

<a id="1.0.78"></a>

## 1.0.78: 2024/02/12 - Client-Pro

<a id="text-1.0.78"></a>

Fix: correctly deserialize URIs to java.net.URI

<a id="outline-container-1.0.7075"></a>

<a id="1.0.7075"></a>

## 1.0.7075: 2023/12/18

<a id="text-1.0.7075"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7075.zip` | 2023/12/18 | 1.0.7075 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7075/datomic-pro-1.0.7075.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7075"]` | 2023/12/18 | 1.0.7075 |  |
|  |  |  |  |

- Peer introduces a new dependency on Apache commons-io. If your app has an existing dependency on commons-io, ensure that you depend on 2.15.1 or greater. An older version will cause the peer to throw either a ClassNotFoundExceptionArray when initializing or an IndexOutOfBoundsException when connecting to a database.
- New GcPauseMsec metric. Check [Transactor Metrics](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md#transactor-metrics).
- Fix: pull expression could return true when supplying a :default for a boolean attribute.
- Fix: regression introduced in 1.0.6527 that could cause a database with blank keyword idents to fail to load.
- Fix: Datomic could incorrectly calculate the delay for a StorageBackoff, leading to a longer than expected delay before retry.
- Performance: replace BufferedInputStream with an unsynchronized stream, important for performance on Java 17 and later.
- Enhancement: provide a better error message when d/connect fails to make a connection.
- Enhancement: increase the number of retries when calling verify-backup on s3 storage.
- Upgraded com.amazonaws/aws-java-sdk-bundle to 1.12.564.
- Upgraded com.cognitect/http-client to 1.0.126.
- Upgraded com.cognitect/transit-clj to 1.0.333.
- Upgraded com.datomic/client-pro to 1.0.77.
- Upgraded com.datomic/memcache-asg-java-client to 1.1.0.36.
- Upgraded com.google.guava/guava to 32.0.1-jre.
- Upgraded org.apache.httpcomponents/httpclient to 4.5.13.
- Upgraded org.apache.httpcomponents/httpcore to 4.4.13.
- Upgraded org.clojure/core.async to 1.6.681.
- Upgraded org.clojure/core.match to 1.0.1.
- Upgraded org.clojure/math.combinatorics to 0.2.0.
- Upgraded org.eclipse.jetty/jetty-\* to 9.4.53.v20231009.
- Upgraded org.msgpack/msgpack to 0.6.12.
- Upgraded org.apache.activemq/artemis\* to 2.31.2.

<a id="outline-container-1.0.77"></a>

<a id="1.0.77"></a>

## 1.0.77: 2023/12/18 - Client-Pro

<a id="text-1.0.77"></a>

- Upgraded com.cognitect/http-client to 1.0.126.
- Upgraded commons-codec to 1.16.0.
- Upgraded org.clojure/core.async to 1.6.681.
- Upgraded org.eclipse.jetty/jetty-\* to 9.4.52.v20230823.
- Upgraded org.msgpack/msgpack to 0.6.12.

<a id="outline-container-1.0.7021"></a>

<a id="1.0.7021"></a>

## 1.0.7021: 2023/10/19

<a id="text-1.0.7021"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.7021.zip` | 2023/10/19 | 1.0.7021 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.7021/datomic-pro-1.0.7021.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.7021"]` | 2023/10/19 | 1.0.7021 |  |
|  |  |  |  |

[Critical Fixes](../03-pro-release-notices/pro-release-notices.md#1.0.7021):

- Fixed regression introduced in 1.0.7010 where query thread pool could deadlock under highly concurrent load, preventing queries from completing.
- Fixed a regression introduced in transactors in 1.0.7010: Peer tx-range can temporarily fail to return a durably-logged transaction coincident with the start of an indexing job until a few more transactions are processed.

<a id="outline-container-1.0.7010"></a>

<a id="1.0.7010"></a>

## 1.0.7010: 2023/10/10

<a id="text-1.0.7010"></a>

| Artifact                        | Release Date | Version  | Release          |
|---------------------------------|--------------|----------|------------------|
| `datomic-pro-1.0.7010.zip`      | 2023/10/10   | 1.0.7010 | Download Removed |
|                                 |              |          |                  |
| `[com.datomic/peer "1.0.7010"]` | 2023/10/10   | 1.0.7010 |                  |
|                                 |              |          |                  |

- Performance: improved storage and cache stack performance.
- Performance: log tree production is now async and separate from transactions.
- Performance: reduced resources required by indexing.
- Performance: improved S3 backup and restore performance.
- New CloudWatch metric: `TransactionApplyMsec`. Check [Transactor Metrics](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md#transactor-metrics).
- New System Property: `ddbRequestTimeout`. Check [System Properties](../../../05-operation/01-pro/11-system-properties/system-properties.md).

<a id="outline-container-1.0.6735"></a>

<a id="1.0.6735"></a>

## 1.0.6735: 2023/06/30

<a id="text-1.0.6735"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.6735.zip` | 2023/06/30 | 1.0.6735 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.6735/datomic-pro-1.0.6735.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.6735"]` | 2023/06/30 | 1.0.6735 |  |
|  |  |  |  |

- Feature: [separated Garbage Collection](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#separated-garbage-collection) tool for Datomic.
- Fixed regression introduced in 1.0.6725 that disabled health check endpoint.

<a id="outline-container-1.0.6733"></a>

<a id="1.0.6733"></a>

## 1.0.6733: 2023/05/18

<a id="text-1.0.6733"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.6733.zip` | 2023/05/18 | 1.0.6733 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.6733/datomic-pro-1.0.6733.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.6733"]` | 2023/05/18 | 1.0.6733 |  |
|  |  |  |  |

Fixed regressions introduced in 1.0.6711:

- Nested entities can incorrectly cause a transaction to fail with a `db.error/cycle-in-affinity`.
- Component entities of a transaction entity are all assigned the entity id of the transaction.

<a id="outline-container-1.0.6726"></a>

<a id="1.0.6726"></a>

## 1.0.6726: 2023/04/27

<a id="text-1.0.6726"></a>

| Artifact | Release Date | Version | Release |
|----|----|----|----|
| `datomic-pro-1.0.6726.zip` | 2023/04/27 | 1.0.6726 | [Download](https://datomic-pro-downloads.s3.amazonaws.com/1.0.6726/datomic-pro-1.0.6726.zip) |
|  |  |  |  |
| `[com.datomic/peer "1.0.6726"]` | 2023/04/27 | 1.0.6726 |  |
|  |  |  |  |

- The peer and transactor binaries are now licensed under the Apache 2.0 license.
- You do not need to specify a license key in the transactor properties file.
- The peer library is now available under the artifact name com.datomic/peer in Maven Central.
- Any com.datomic support libraries needed by the peer are available in Maven Central.
- The spymemcached library used by Datomic has been shaded to the package name datomic.spy.memcached to avoid conflict with other forks of spymemcached.

<a id="outline-container-1.0.6711"></a>

<a id="1.0.6711"></a>

## 1.0.6711: 2023/04/20

<a id="text-1.0.6711"></a>

- Feature: [implicit partitions](../../../06-reference/01-schema/01-schema-reference/schema-reference.md).
- Feature: *:db/force-partition* and *:db/match-partition*. Check [Partition assignment](../../../06-reference/02-transactions/transactions.md).
- Upgrade: the transactor and peer now require an LTS version of Java 1.11 or greater.
- Upgraded artemis to 2.28.0.
- Upgraded caffeine to 3.1.5.
- Upgraded ring to 1.10.0.

<a id="outline-container-1.0.6644"></a>

<a id="1.0.6644"></a>

## 1.0.6644: 2023/04/03

<a id="text-1.0.6644"></a>

- Performance: indexing is more aggressive in removing `:db/noHistory` datoms.
- Fix: transaction no longer times out if a user transaction function puts unfressianable data in an exception.
- Fix: very rare situation where a transaction could be included in the index but not in the log.
- Upgraded H2 to 2.1.214.

<a id="outline-container-1.0.76"></a>

<a id="1.0.76"></a>

## 1.0.76: 2023/02/27 - Client-Pro

<a id="text-1.0.76"></a>

- Feature: [Io-stats](../../../04-apis/11-io-stats/io-stats.md) for transactions and queries.
- Feature: [Query-stats](../../../04-apis/12-query-stats/query-stats.md) for transactions and queries.

<a id="outline-container-1.0.6610"></a>

<a id="1.0.6610"></a>

## 1.0.6610: 2023/01/25

<a id="text-1.0.6610"></a>

- Feature: [query-stats](../../../04-apis/12-query-stats/query-stats.md).
- Performance: improved performance accessing DDB with high write concurrency.
- Performance: improved performance accessing S3 with high write concurrency.
- Performance: improved fressian read.
- Fix: pull performance regression introduced in 1.0.6527.
- Fix: exception when using io-stats in nested contexts, you should no longer see "No implementation of method: :-merge-stats of protocol".
- Fix: [restart memcached client when needed to work around](https://issues.couchbase.com/browse/SPY-196).
- Fix: fail fast if indexing thread is hung waiting on storage response.
- Upgraded PostgreSQL driver to 42.5.1.
- Upgraded AWS libraries to 1.12.358.

<a id="outline-container-1.0.6527"></a>

<a id="1.0.6527"></a>

## 1.0.6527: 2022/10/21

<a id="text-1.0.6527"></a>

- Feature: [io-stats](../../../04-apis/11-io-stats/io-stats.md) for transactions and queries.
- Feature: [verify backups](../../../05-operation/01-pro/08-backup-and-restore/backup-and-restore.md#verifying-backups) without performing a restore.
- Performance: improved peer adoption of new indexes.
- Performance: improved performance (throughput and \$) for differential backups to S3.
- Performance: Datomic now uses caffeine instead of guava for the object cache.
- Performance improvements for Valcache and the object cache.
- Performance: limit thread and memory usage when the transactor is [adding an AVET index](../../../06-reference/01-schema/02-changing-schema/changing-schema.md).
- Fix: peer no longer resolves lookup refs before sending tx data to transactor.
- Fix: attribute names that begin with an underscore can be used for forward lookups in entity and pull. Note that naming attributes with a leading underscore is strongly discouraged because it conflicts with the convention for reverse lookup.

<a id="outline-container-1.0.6397"></a>

<a id="1.0.6397"></a>

## 1.0.6397: 2022/04/05

<a id="text-1.0.6397"></a>

- New API: add :release-object-cache to [d/administer-system](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/administer-system).
- New: expose configuration to set the Memcached item expiration in days. Check [System Properties](../../../05-operation/01-pro/11-system-properties/system-properties.md).
- Feature: support for DynamoDB in additional regions (including eu-north-1).
- Feature: add support for JDK17.
- Notes: updated EULA.
- Upgraded artemis to 2.19.1.
- Upgraded com.datomic/memcache-asg-java-client to 1.1.0.33.
- Upgraded transit-clj to 1.0.329.
- Upgraded aws-sdk-bundle to 1.12.132.
- Upgraded client-pro to 1.0.75.
- Upgraded Clojure to 1.11.0 in transactor.

<a id="outline-container-1.0.75"></a>

<a id="1.0.75"></a>

## 1.0.75: 2022/04/05 - Client-Pro

<a id="text-1.0.75"></a>

Upgrade Client to 1.0.126.

<a id="outline-container-1.0.6362"></a>

<a id="1.0.6362"></a>

## 1.0.6362: 2022/01/05

<a id="text-1.0.6362"></a>

- Fix: don't print or log connection info by default in peer-server.
- Fix: regression introduced in 1.0.6344 preventing the use of `:db-after` with peer-server.
- Fix: replace slf4j-nop dependency with slf4j-api.
- Upgraded com.datomic/memcache-asg-java-client to 1.1.0.32.
- Upgraded embedded REBL to 0.9.242.
- Upgraded core.async to 1.5.648.
- Upgraded commons-codec to 1.15.
- Upgraded Jetty to 9.4.44.v20210927.
- Upgraded logback-classic to 1.2.8.
- Upgraded org.slf4j libs to 1.7.32.
- Upgraded Guava to 31.0.1.
- Upgraded AWS Java SDK to 1.12.100.
- Upgraded Tomcat-JDBC to 7.0.109.

<a id="outline-container-1.0.74"></a>

<a id="1.0.74"></a>

## 1.0.74: 2022/01/05 - Client-Pro Update

<a id="text-1.0.74"></a>

- Upgraded AWS Java SDK to 1.12.100.
- Upgraded Jetty to 9.4.44.v20210927.
- Upgraded core.async to 1.5.648.
- Upgraded core.cache to 1.0.225.
- Upgraded data.priority-map to 1.1.0.
- Upgraded http-client to 1.0.110.

<a id="outline-container-0.1.233"></a>

<a id="0.1.233"></a>

## 0.1.233 2022/01/05 - Console Update

<a id="text-0.1.233"></a>

- Upgraded Jetty to 9.4.44.v20210927
- Upgraded logback-classic to 1.2.8

<a id="outline-container-1.0.6344"></a>

<a id="1.0.6344"></a>

## 1.0.6344: 2021/09/15

<a id="text-1.0.6344"></a>

- New API: `Database.dbStats`. Check [dbStats](../../../04-apis/02-peer-api-javadoc/interfaces/database/database.md).
- Fix: prevent a problem where in rare situations indexing jobs can fail repeatedly with an `ArityException` in the transactor log.
- Fix: prevent a problem where in rare situations indexing jobs can fail to progress, leading to `AlarmBackPressure` and operators needing to restart the transactor process.
- Fix: ensure that `d/log` is only as recent as `d/db`.
- Fix: regression introduced in 1.0.6316 that caused memcache client to fail to start when using SASL authentication.
- Fix: regression introduced in 1.0.6316 that could prevent reporting of metrics to Cloudwatch.
- Fix: redact memcache password in log data.
- Fix: don't print connection URI to log.
- Fix: don't expose database credentials when printing `db` value.
- Change the transactor property `datomic.printConnectionInfo` default to false.
- Enhancement: bin/maven-install now installs memcache-asg-java-client to the local maven repository.
- Upgraded Clojure to 1.10.3.
- Upgraded AWS Java SDK to 1.12.1.
- Upgraded Jetty to 9.4.41.v20210516.
- Upgraded ActiveMQ Artemis to 2.17.0.
- Upgraded core.async to 1.3.618.
- Upgraded data.json to 2.4.0.
- Upgraded tools.cli to 1.0.206.
- Upgraded org.fressian to 0.6.6.
- Upgraded transit-clj to 1.0.324.

<a id="outline-container-1.0.72"></a>

<a id="1.0.72"></a>

## 1.0.72: 2021/09/15 - Client-Pro Update

<a id="text-1.0.72"></a>

- Upgraded core.async to 1.3.618.
- Upgraded transit-clj to 1.0.324.
- Upgraded Jetty to 9.4.41.v20210516.

<a id="outline-container-console-227"></a>

<a id="console-227"></a>

## 0.1.227 2021/09/15 - Console Update

<a id="text-console-227"></a>

- Upgraded Clojure to 1.10.3.
- Upgraded Jetty to 9.4.41.v20210516.
- Upgraded tools.cli to 1.0.206.

<a id="outline-container-1.0.6316"></a>

<a id="1.0.6316"></a>

## 1.0.6316: 2021/07/22

<a id="text-1.0.6316"></a>

- New feature: AWS memcached auto-discovery Check [node auto discovery](../../../05-operation/01-pro/09-memory-and-caching/memory-and-caching.md#node-auto-discovery).
- Improved performance for query under heavy parallel load.
- Fix: attribute specs respect `false` values when ensuring attribute existence.

<a id="outline-container-1.0.6269"></a>

<a id="1.0.6269"></a>

## 1.0.6269: 2021/03/09

<a id="text-1.0.6269"></a>

Changed in 1.0.6269

- Fixed intermittent ClassCastException in `:reverse` direction of `index-pull`.
- Improved performance for query under heavy parallel load.
- Improved performance for indexing after excision.
- Upgraded ActiveMQ Artemis to 2.14.0.
- Upgraded guava to 30.1-jre.
- Upgraded Clojure contrib deps to their 1.0.x versions.
- Upgraded org.slf4j libs to 1.7.30.
- Upgraded AWS Java SDK to 1.11.946.

<a id="outline-container-1.0.6242"></a>

<a id="1.0.6242"></a>

## 1.0.6242: 2021/01/27

<a id="text-1.0.6242"></a>

Changed in 1.0.6242

- Fix: [attribute predicates](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#attribute-predicates) are now applied to assertions only.
- Upgrade to presto 348 for [Datomic analytics](../../../08-analytics/04-sql-cli/sql-cli.md).

<a id="outline-container-0.9.66"></a>

<a id="0.9.66"></a>

## 0.9.66: 2021/01/20 - Client-pro update

<a id="text-0.9.66"></a>

Improvment: make client dynaload thread-safe.

<a id="outline-container-1.0.6222"></a>

<a id="1.0.6222"></a>

## 1.0.6222: 2020/11/23

<a id="text-1.0.6222"></a>

Changed in 1.0.6222

- New: change the scale of a [BigDecimal attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md) in a transaction.
- New: add `:apply-msec` key to `:tx/process` events in the log, useful for identifying slow transactions.
- Upgrade to Presto 346 for [Datomic analytics](../../../08-analytics/01-analytics-concepts/analytics-concepts.md).

<a id="outline-container-1.0.6202"></a>

<a id="1.0.6202"></a>

## 1.0.6202: 2020/08/06

<a id="text-1.0.6202"></a>

Changed in 1.0.6202

- New feature: [cancel](../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md#canceling).
- Upgrade: the version of the bundled Presto server is now 338. Note: This upgrade now requires Java 11 to run the Presto server.
- Fix: prevent a race condition in Valcache that could lead to a failed read.
- Fix: regression introduced in 1.0.6165 that caused Datomic Console to fail to start on recent versions of Datomic.
- Fix: prevent a situation where `tx-range` sometimes returns one extra transaction before a specified instant.

<a id="outline-container-client-0-9-63"></a>

<a id="client-0-9-63"></a>

## 0.9.63: 2020/07/21 - Client-Pro Update

<a id="text-client-0-9-63"></a>

Fix: datomic.api.client.async/client now accepts :dev-local as a :server-type.

<a id="outline-container-client-0-9-62"></a>

<a id="client-0-9-62"></a>

## 0.9.62: 2020/07/17 - Client-Pro Update

<a id="text-client-0-9-62"></a>

Add support for [dev-local](../../../01-setup/03-local-setup/local-setup.md) clients.

<a id="outline-container-console-225"></a>

<a id="console-225"></a>

## Console 0.1.225 2020/05/29

<a id="text-console-225"></a>

Fixed bug that caused Console to fail to start on newer versions of Datomic.

> **NOTE:** This is a stand-alone console release. You can download the console [here](https://my.datomic.com/downloads/console).

<a id="outline-container-1.0.6165"></a>

<a id="1.0.6165"></a>

## 1.0.6165: 2020/05/14

<a id="text-1.0.6165"></a>

- New feature: [qseq](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md#qseq).
- New feature:[index-pull](../../../04-apis/06-index-pull/index-pull.md).
- New feature: [pull xform](../../../06-reference/03-query-and-pull/03-pull/pull.md).
- Upgrade: the transactor and peer now require Java 1.8 or greater.
- Enhancement: optimize cache usage of queries that pull.
- Enhancement: improve index efficiency.
- Fix: only read \*.edn metaschema files in analytics support.
- Updated REST server jetty dependencies from 9.4.24.v20191120 to 9.4.27.v20200227.
- Updated liberator (used in REST server) to 0.15.3.

<a id="outline-container-0.9.57"></a>

<a id="0.9.57"></a>

## 0.9.57: 2020/05/14 - Client-Pro Update

<a id="text-0.9.57"></a>

- New feature: [qseq](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md#qseq).
- New feature: [index-pull](../../../04-apis/06-index-pull/index-pull.md).
- Updated jetty dependencies from 9.4.24.v20191120 to 9.4.27.v20200227.

<a id="outline-container-0.9.6045"></a>

<a id="0.9.6045"></a>

## 0.9.6045: 2020/02/13

<a id="text-0.9.6045"></a>

- New feature: `[:db/retract eid aid]` will retract all values for an eid/aid combination.
- [Critical fix](../03-pro-release-notices/pro-release-notices.md#0.9.6045): regression introduced in 0.9.6014 where `datoms`, `seek-datoms`, and `index-range` return incorrect results if `Iterable.iterator` is called more than once on the returned value.
- Fix: respect `nil` as a limit in query `pull` expression.
- Fix: respect `false` as a default in query `pull` expressions for boolean-valued attributes.
- Fix: allow arbitrary `java.util.List` (not just Clojure vectors) for lookup refs.
- Updated REST server jetty dependencies from 9.4.15.v20190215 to 9.4.24.v20191120.
- Updated bundled Presto server from 316 to 329.
- Removed Groovy from the transactor distribution. This was unused except for examples.

<a id="outline-container-0.9.6024"></a>

<a id="0.9.6024"></a>

## 0.9.6024: 2020/01/14

<a id="text-0.9.6024"></a>

- Eliminate unnecessary peer dependency on core.async and tools.reader introduced in 0.9.6014.
- Fix: `#db/fn` literals preserve `:code` metadata.

<a id="outline-container-0.9.6021"></a>

<a id="0.9.6021"></a>

## 0.9.6021: 2020/01/08

<a id="text-0.9.6021"></a>

- Fix: prevent a rare scenario where retracting non-existent entities could prevent future transactions from succeeding.
- Update transactor core.async dependency to 0.5.527.

<a id="outline-container-0.9.6014"></a>

<a id="0.9.6014"></a>

## 0.9.6014: 2019/12/13

<a id="text-0.9.6014"></a>

- Enhancement: performance improvement for range predicates in analytics support.
- Enhancement: many error maps now include the tempid mappings for data that caused a transaction to fail.
- Enhancement: when the transactor is unavailable, the peer returns an error including a `:cognitect.anomalies/unavailable` category.
- Fix: improve performance of lookup refs against as-of databases.
- Fix: include bash shebang in `bin/maven-install`.
- Fix: report an error on invalid aggregate function names in query.

<a id="outline-container-0.9.5981"></a>

<a id="0.9.5981"></a>

## 0.9.5981: 2019/10/21

<a id="text-0.9.5981"></a>

- New: `index-parallelism` transactor property enables higher index job throughput.

[Index Parallelism](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#index-parallelism).

- Fix: prevent exception thrown when handling COUNT(\*) clauses in analytics support.
- Fix: resolve tempids for reference attributes inside tuples.
- Fix: do not create redundant `:db.install/attribute` datoms for idempotent schema operations.
- Update transactor Clojure dependency to 1.10.1.

<a id="outline-container-0.9.5966"></a>

<a id="0.9.5966"></a>

## 0.9.5966: 2019/10/01

<a id="text-0.9.5966"></a>

- New feature preview: analytics.
- Updated AWS library dependency to 1.11.600.
- Expanded the retry window for backup and restore operations. This helps backup and restore jobs completely in the face of transient errors.
- Stopped reporting transaction errors asynchronously.

<a id="outline-container-0.9.5951"></a>

<a id="0.9.5951"></a>

## 0.9.5951: 2019/07/31

<a id="text-0.9.5951"></a>

- Redact password in exception data when peer connection fails.
- Correctly handle boolean attributes in composite tuples.
- Updates to address vulnerabilities in Apache dependencies:
  - Jackson from 2.6.6 to 2.9.9.
  - Logback from 1.0.13 to 1.2.0.
  - Zookeeper 3.4.6 to 3.5.5.

<a id="outline-container-0.9.5930"></a>

<a id="0.9.5930"></a>

## 0.9.5930: 2019/07/02

<a id="text-0.9.5930"></a>

Fixed problem where databases that change an attribute from `:db.cardinality/one` to~:db.cardinality/many~ may become unavailable after a process restart.

<a id="outline-container-0.9.5927"></a>

<a id="0.9.5927"></a>

## 0.9.5927: 2019/06/28

<a id="text-0.9.5927"></a>

- New feature: [Tuples](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#tuples).
- New feature: [attribute predicates](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#attribute-predicates).
- New feature: [entity specs](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#entity-specs).
- New feature: [return maps](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#return-maps).
- New feature: [Cassandra2](../../../05-operation/01-pro/01-storage-services/storage-services.md).
- Vulnerability Fix: Updated [commons Collections](https://issues.apache.org/jira/browse/COLLECTIONS-580) from 3.2.1 to 3.2.2.
- Fix: `sample` aggregate could hang the query thread.
- Improved performance of Valcache cleanup.
- Updated REST server jetty dependencies from 9.3.7.v20160115 to 9.4.15.v20190215.
- Updated ActiveMQ Artemis dependencies from 1.4.0 to 1.5.6.

<a id="outline-container-client-0-9-37"></a>

<a id="client-0-9-37"></a>

## 0.9.37: 2019/06/27 - Client-Pro Update

<a id="text-client-0-9-37"></a>

- New feature: [return maps](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#return-maps).
- New feature: reverse references in `nav` (try it in [REBL](https://cognitect.com/dev-tools)).

<a id="outline-container-0.9.5786"></a>

<a id="0.9.5786"></a>

## 0.9.5786 2018/11/15

<a id="text-0.9.5786"></a>

Fix: re-enable memcached support which was inadvertently disabled in 0.9.5783.

<a id="outline-container-client-0-8-28"></a>

<a id="client-0-8-28"></a>

## 0.8.28: 2018/11/27 - Client-Pro Update

<a id="text-client-0-8-28"></a>

- Add compatibility with com.cognitect/aws-api.
- Add Datafy.
- Improved error reporting.
- Upgraded http-client to 0.1.87.

<a id="outline-container-0.9.5783"></a>

<a id="0.9.5783"></a>

## 0.9.5783: 2018/10/10

<a id="text-0.9.5783"></a>

- New feature: [Valcache](../../../05-operation/01-pro/13-valcache/valcache.md).
- Fixed cache problem in peer-server where all `d/with` databases deriving from a common initial call to `d/with-db` had the same common value.
- Fixed bug introduced in 0.9.5703 that prevented using class static methods in query function expressions.

<a id="outline-container-client-0-8-20"></a>

<a id="client-0-8-20"></a>

## 0.8.20: 2018/08/21 - Client-pro update

<a id="text-client-0-8-20"></a>

- Bugfix: fixed Jetty configuration that could cause a client to prevent JVM from shutting down.
- Upgraded transit-clj to 0.8.313.

<a id="outline-container-client-0-8-17"></a>

<a id="client-0-8-17"></a>

## 0.8.17: 2018/07/02 - Client-pro update

<a id="text-client-0-8-17"></a>

Enhancement: added sync to Client API. [Client Synchronization](../../../06-reference/02-transactions/06-client-synchronization/client-synchronization.md).

<a id="outline-container-0.9.5703"></a>

<a id="0.9.5703"></a>

## 0.9.5703 2018/06/06

<a id="text-0.9.5703"></a>

New feature: [classpath functions](../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md#types).

<a id="outline-container-0.9.5697"></a>

<a id="0.9.5697"></a>

## 0.9.5697 2018/03/29

<a id="text-0.9.5697"></a>

- Release 0.9.5697 fixes two [security vulnerabilities](https://forum.datomic.com/t/important-security-update-0-9-5697/379) in Datomic On-Prem transactors running the free: or dev: storage protocol.
- Enhancement: new security configuration options for free: and dev: transactors.

<a id="outline-container-0.9.5661"></a>

<a id="0.9.5661"></a>

## 0.9.5661 2018/01/11

<a id="text-0.9.5661"></a>

- Upgrade: updated Transactor AMIs for all regions to the latest Amazon Linux. Note that per AWS guidelines PV AMIs are no longer provided.
- Added support for eu-west-3 region.

<a id="outline-container-0.9.5656"></a>

<a id="0.9.5656"></a>

## 0.9.5656 2017/12/05

<a id="text-0.9.5656"></a>

New feature: `:as` and `attr-with-opts` syntax in [the pull API](../../../06-reference/03-query-and-pull/03-pull/pull.md).

<a id="outline-container-0.9.5651"></a>

<a id="0.9.5651"></a>

## 0.9.5651 2017/11/29

<a id="text-0.9.5651"></a>

- Enhancement: peer server allows arbitrary code in queries.
- Enhancement: better error messages from peer server.

<a id="outline-container-0.9.5561.62"></a>

<a id="0.9.5561.62"></a>

## 0.9.5561.62 2017/10/06

<a id="text-0.9.5561.62"></a>

- Bugfix: transactors and peers now use disjoint ranges for tempid generation, so tempids generated in transaction functions cannot collide with tempids generated on the peer.
- Bugfix: fixed a bug where starting a peer and transactor at about the same time could lead to a string tempid incorrectly unifying with another tempid in the same transaction.

<a id="outline-container-0.9.5561.59"></a>

<a id="0.9.5561.59"></a>

## 0.9.5561.59 2017/09/20

<a id="text-0.9.5561.59"></a>

Bugfix: fixed bug that prevented health check endpoint from starting on machines with more than 8 cores.

<a id="outline-container-0.9.5561.56"></a>

<a id="0.9.5561.56"></a>

## 0.9.5561.56 2017/08/16

<a id="text-0.9.5561.56"></a>

Bugfix: stop printing sensitive Cassandra connection information in the log.

<a id="outline-container-0.9.5561.54"></a>

<a id="0.9.5561.54"></a>

## 0.9.5561.54 2017/07/24

<a id="text-0.9.5561.54"></a>

- Bugfix: fixed an HA performance bug where a transactor could continue to write a heartbeat during the shutdown, causing up to 30 second delay before the standby transactor could take over.
- Enhancement: more efficient index use in transaction processing. This will improve write latency and throughput for some update-heavy transaction loads.

<a id="outline-container-0.9.5561.50"></a>

<a id="0.9.5561.50"></a>

## 0.9.5561.50 2017/06/07

<a id="text-0.9.5561.50"></a>

- Bugfix: release 0.9.5561.50 fixes a bug in the catalog that, in the unlikely circumstance where one has deleted a database and restored it from a backup without first having called `gc-deleted-dbs`, can cause a subsequent `gc-deleted-dbs` to delete that (active) database.
- Bugfix: prevent unbounded thread use by query pool.
- Upgrade: peers and transactors now use version 1.11.82 of the AWS SDK.
- Upgrade: updated the AWS regions and instance types available via the CloudFormation template.
- Enhancement: better error message when unable to resolve an entity.
- Enhancement: health check endpoints for transactors and peer servers.

<a id="outline-container-0.9.5561"></a>

<a id="0.9.5561"></a>

## 0.9.5561 2017/02/13

<a id="text-0.9.5561"></a>

Bugfix: fixed a bug where the peer server could ignore the `basis-t` of a client request, answering queries from the latest db value instead.

<a id="outline-container-0.9.5554"></a>

<a id="0.9.5554"></a>

## 0.9.5554 2017/01/23

<a id="text-0.9.5554"></a>

- Bugfix: fixed bug where queries with variables in attribute position could return tuples that differ only by Java representation, e.g. a tuple with Integer 1 and a 'different' tuple with Long 1.
- Bugfix: fixed a bug where an ident that has been used to name more than one different entity over time could return an outdated entity id from e.g. `d/entid`.
- Improvement: better performance in creating memory databases.

<a id="outline-container-0.9.5544"></a>

<a id="0.9.5544"></a>

## 0.9.5544 2016/12/06

<a id="text-0.9.5544"></a>

Bugfixes in new functionality introduced in 0.9.5530:

- Clients can now query values produced by `with-db`.
- String tempids are now available in the `:tempids` key returned by e.g. `transact`.
- Indexing jobs correctly handles the implicit use of `:db.install/attribute` and `:db.alter/attribute`.

<a id="outline-container-0.9.5530"></a>

<a id="0.9.5530"></a>

## 0.9.5530 2016/11/28

<a id="text-0.9.5530"></a>

- New feature: [clients and peers](../../../introduction.md#datomic-APIs) and [Peer Server](../../../05-operation/01-pro/16-peer-server/peer-server.md).
- New feature: [string tempids](../../../06-reference/02-transactions/transactions.md).
- Improvement: `db.install/attribute` and `db.alter/attribute` are [now optional](../../../06-reference/01-schema/02-changing-schema/changing-schema.md).

<a id="outline-container-0.9.5407"></a>

<a id="0.9.5407"></a>

## 0.9.5407 2016/10/28

<a id="text-0.9.5407"></a>

- Bugfix: fixed bug introduced in 0.9.5404 where peers do not reconnect after losing the transactor connection until the peer makes another call to the transactor.
- Performance improvement for queries where AVET is more selective than VAET.

<a id="outline-container-0.9.5404"></a>

<a id="0.9.5404"></a>

## 0.9.5404 2016/09/28

<a id="text-0.9.5404"></a>

- Upgrade: the transactors and the peer now work with Cassandra 3.1.0 driver.
- Upgrade: the transactor and the peer now use ActiveMQ Artemis 1.4.0. Peers from this release forward -cannot- connect to older transactors. When upgrading to (or past) this release, you must upgrade transactors first.

<a id="outline-container-0.9.5394"></a>

<a id="0.9.5394"></a>

## 0.9.5394 2016/08/15

<a id="text-0.9.5394"></a>

- Bugfix: eliminated a bug where given a particular and extremely unlikely interleaving of indexing failures and transactor successions, some transactions can be incorporated into the log but not in the indexes.
- Bugfix: `:db.fn/cas` now rejects attemps to CAS a cardinality-many attribute.

<a id="outline-container-0.9.5390"></a>

<a id="0.9.5390"></a>

## 0.9.5390 2016/08/03

<a id="text-0.9.5390"></a>

- Improvement: the `log` API can now be used with the memory database.
- Bugfix: a unique attribute value can now be transferred from one entity to another within a transaction.

<a id="outline-container-0.9.5385"></a>

<a id="0.9.5385"></a>

## 0.9.5385 2016/06/29

<a id="text-0.9.5385"></a>

- Upgrade: the transactor and peer now use HornetQ 2.4.7. Peers from this release forward -cannot- connect to older transactors. When upgrading to (or past) this release, you must upgrade transactors first.
- Upgrade: Datomic now uses AWS SDK 1.11.6.
- Bugfix: substantially improved the performance of a corner case involving transactions with a large number of retractions.
- Bugfix: fixed bug where AVET index could become temporarily unavailable on a recently added attribute.
- Bugfix: Clojure begins now work in transaction FNS.

<a id="outline-container-0.9.5372"></a>

<a id="0.9.5372"></a>

## 0.9.5372 2016/05/31

<a id="text-0.9.5372"></a>

- Upgrade: the transactor and peer now require Clojure 1.8.0 or greater.
- Bugfix: prevent a scenario where not all predicates were applied in queries with a `not` clause.
- Bugfix: respect `default` specifications in pull expressions containing a wildcard.
- Bugfix: allow `isComponent` only on ref types in new data, and ignore meaningless `isComponent` specifications on non-ref types in existing data.

<a id="outline-container-0.9.5359"></a>

<a id="0.9.5359"></a>

## 0.9.5359 2016/04/25

<a id="text-0.9.5359"></a>

- Improvement: all Datomic command line tools now use the standard AWS credentials provider.
- Bugfix: improved performance of pull + wildcard + since database.
- Bugfix: fixed bug that could in rare cases cause a peer to be unable to reconnect to a transactor after a transient failure.
- Bugfix: eliminated a few spurious maven dependencies from the Peer library.

<a id="outline-container-0.9.5350"></a>

<a id="0.9.5350"></a>

## 0.9.5350 2016/02/09

<a id="text-0.9.5350"></a>

- Improvement: connection caching behavior has been changed so that peers can now connect to the same database served by two (or more) different transactors.
- Bugfix: it is no longer possible to create a database name that will result in an invalid URI.

<a id="outline-container-0.9.5344"></a>

<a id="0.9.5344"></a>

## 0.9.5344 2015/12/03

<a id="text-0.9.5344"></a>

- Notice: the full Amazon AWS SDK for Java is no longer shipped with the Datomic peer library. If you are using AWS, see the section in the storage docs about including the AWS SDK for Java for help with configuring your peer with this upgrade: [provisioning-dynamo](../../../05-operation/01-pro/01-storage-services/storage-services.md).
- New: the transactor and peer now require Clojure 1.7.0 or greater.
- Improvement: remove dependency on monolithic AWS SDK for Java library.
- Improvement: add support for eu-central-1.
- Improvement: throw error when `datomic.api/pull` is passed a history db.
- Bugfix: fixed bug that could cause a transactor to report a spurious error message after a successful restore if the transactor wasn't running.
- Bugfix: fixed bug that could, in unusual circumstances, cause a database to fail to load with an NPE in datomic.db-next_valid_inst

<a id="outline-container-0.9.5327"></a>

<a id="0.9.5327"></a>

## 0.9.5327 2015/10/13

<a id="text-0.9.5327"></a>

- Bugfix: fixed bug that could cause a transactor to terminate when deleting a database against Cassandra's storage.
- Bugfix: fixed bug where retracting an excision could cause indexing to fail.
- Bugfix: fixed bug that prevented connecting from a peer that deletes and recreates a database name.

<a id="outline-container-0.9.5302"></a>

<a id="0.9.5302"></a>

## 0.9.5302 2015/09/17

<a id="text-0.9.5302"></a>

- Bugfix: eliminated a bug where given a particular and extremely unlikely interleaving of indexing failures and transactor successions, some transactions can be incorporated into the log but not in the indexes.
- Bugfix: improved storage garbage tracking.
- Fixed bug that could cause processes using Cassandra driver to hang during peer shutdown.

<a id="outline-container-0.9.5206"></a>

<a id="0.9.5206"></a>

## 0.9.5206 2015/07/30

<a id="text-0.9.5206"></a>

Bugfix: Document and enforce [limitations](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#bytes-limitations) of `:db.type/bytes`.

<a id="outline-container-0.9.5201"></a>

<a id="0.9.5201"></a>

## 0.9.5201 2015/07/16

<a id="text-0.9.5201"></a>

Reduced memory and thread use in DDB storage when writing large segments.

<a id="outline-container-0.9.5198"></a>

<a id="0.9.5198"></a>

## 0.9.5198 2015/07/06

<a id="text-0.9.5198"></a>

- Fixed bug where dropping and re-adding index on an attribute could lead to retracted values reappearing in the AVET index.
- Fixed bug where in rare cases the log API could be temporarily unable to see the most recent transaction.
- Fixed bug where the pull API did not always return all explicit reverse references.

<a id="outline-container-0.9.5186"></a>

<a id="0.9.5186"></a>

## 0.9.5186 2015/06/18

<a id="text-0.9.5186"></a>

- Improvement: better error reporting when an invalid entity id is transacted.
- Improvement: work around a retry bug in Cassandra that can cause unnecessary failures, check [this document](https://datastax-oss.atlassian.net/browse/JAVA-764).
- Improvement: preserve ordering of `:db/txInstant`: If the transactor's system clock returns a value older than the time of the most recent tx, use the most recent tx's instant instead.
- Updated to aws-java-sdk 1.9.39.
- Updated to com.datastax.cassandra/cassandra-driver-core to 2.1.5.
- Fixed bug in Pull API when using selectors built from strings.
- Fixed bug that prevented backup/restores from working in the previous datomic-free release.

<a id="outline-container-0.9.5173"></a>

<a id="0.9.5173"></a>

## 0.9.5173 2015/05/12

<a id="text-0.9.5173"></a>

- Improvement: getting log value from a connection is now much faster.
- Improvement: `restore-db` now prints the basis of the restored database.
- Improvement: metrics can now be enabled during backup/restore.
- Fixed bug: `:db.fn/retractEntity` no longer throws an exception when passed an invalid entity identifier.
- Fixed bug where `syncIndex` API future could fail to complete.

<a id="outline-container-0.9.5153"></a>

<a id="0.9.5153"></a>

## 0.9.5153 2015/03/19

<a id="text-0.9.5153"></a>

- New feature: [query timeout](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md).
- Improvement: the datalog engine will now do self-unification within a single clause.
- Improvement: better semantics for query function `/`: [built-in-expressions](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md).
- Improvement: better error reporting when a query attempts to use a non-attribute as an attribute.
- Fixed a bug that could cause a recursive query to return an undersized result.
- Fixed a bug that could cause restore to fail on a case-sensitive file system.
- Fixed bug that could throw a Null Pointer Exception when calling API functions on nonexistent identities.

<a id="outline-container-0.9.5130"></a>

<a id="0.9.5130"></a>

## 0.9.5130 2015/01/13

<a id="text-0.9.5130"></a>

- Note: we are looking for feedback on this initial release of `not` clauses and `or` clauses described below. The API is subject to change based on this feedback. See [this blog post](https://blog.datomic.com/2015/01/datalog-enhancements.html) for an overview of the new features.
- New feature: [`not` clauses](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#not-clauses).
- New feature: [`or` clauses](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#or-clauses).
- New feature: require vars [in rules](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md).
- Improvement: backing up to the same storage is now differential.
- Performance Enhancement: the query engine will make better use of AVET indexes when range predicates are used in the query.
- Improvement: `Peer.getDatabaseNames` can accept a map for Cassandra and SQL storages: [getDatabaseNames](../../../04-apis/02-peer-api-javadoc/classes/peer/peer.md).
- Improvement: better error messages from invalid transactions.
- Update com.datastax.cassandra/cassandra-driver-core to 2.0.8.

<a id="outline-container-0.9.5078"></a>

<a id="0.9.5078"></a>

## 0.9.5078 2014/11/25

<a id="text-0.9.5078"></a>

- New CloudWatch metrics: `WriterMemcachedPutMusec`, `WriterMemcachedPutFailedMusec` `ReaderMemcachedPutMusec` and `ReaderMemcachedPutFailedMusec` track writes to [Memcache](../../../05-operation/01-pro/09-memory-and-caching/memory-and-caching.md#memcached).
- Improvement: better startup performance for databases using fulltext.
- Improvement: enhanced the Getting Started examples to include the Pull API and find specifications.
- Improvement: better scheduling of indexing jobs during bursty transaction volumes.
- Fixed bug where Pull API could incorrectly return renamed attributes.
- Fixed bug that caused `db.fn/cas` to throw an exception when `false` was passed as the new value.

<a id="outline-container-0.9.5067"></a>

<a id="0.9.5067"></a>

## 0.9.5067 2014/11/07

<a id="text-0.9.5067"></a>

- Improvement: stronger validation on schema value types and cardinalities.
- Improvement: better error logging for Cassandra.
- Fixed a bug that could cause an exception when using limits in a recursive pull specification.

<a id="outline-container-0.9.5052"></a>

<a id="0.9.5052"></a>

## 0.9.5052 2014/10/28

<a id="text-0.9.5052"></a>

- New feature:[pull](https://blog.datomic.com/2014/10/datomic-pull.html). Check this [pull](../../../06-reference/03-query-and-pull/03-pull/pull.md) documentation.
- New feature: [query find specifications](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md).
- New feature: [query pull expressions](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#pull-expressions).
- New: [`Peer.getDatabaseNames`](../../../04-apis/02-peer-api-javadoc/classes/peer/peer.md).
- New: [peer custom monitoring](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md#custom).
- Fixed bug that could cause `Peer.shutdown` to hang.
- Fixed bug that could cause `Peer.createDatabase` to leak threads.
- Fixed bug where nested queries could deadlock.
- Downgraded groovy-all dependency to 1.8.9

<a id="outline-container-0.9.4956"></a>

<a id="0.9.4956"></a>

## 0.9.4956 2014/10/10

<a id="text-0.9.4956"></a>

- Notice: PostgreSQL is no longer shipped with the Datomic peer library. If you are using PostgreSQL, see the section in the storage docs about JDBC drivers for help with configuring your peer with this upgrade: [sql-database](../../../05-operation/01-pro/01-storage-services/storage-services.md#sql-database).
- New: `cassandra-cluster-callback` transactor property for configuring a [Cassandra](../../../05-operation/01-pro/01-storage-services/storage-services.md#cassandra) cluster.
- New: [garbage collection](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md#garbage-collection-deleted) for deleted databases.
- New: transactions now support Clojure bigint literals.
- New: `groovysh.cmd` for Windows.
- Improvement: better failover handling for high availability.
- Improvement: better handling of intra-transaction unique identity violations.
- Improvement: provisioning a new Cloud Formation is now idempotent in an AWS VPC.
- Improvement: `Database.attribute` now returns nil for non-existent attributes.
- Improvement: peers no longer try to reconnect to deleted databases.
- Updated peer library dependencies to the following versions: aws-java-sdk: 1.8.11 cassandra-driver-core: 2.0.6 curator-framework: 2.6.0 groovy-all: 2.3.6 guava: 18.0 postgresql: 9.3.1102 JDBC 4.1 slf4j: 1.7.7 spymemcached: 2.11.4
- Fixed bug that caused DynamoDB Local URIs to ignore AWS credentials.
- Fixed bug that could cause `Database.id` to throw an exception against a Cassandra storage.
- Fixed a bug that could cause process to hang during peer shutdown.

<a id="outline-container-0.9.4899"></a>

<a id="0.9.4899"></a>

## 0.9.4899 2014/09/09

<a id="text-0.9.4899"></a>

- New: the transactor and peer now require Clojure 1.6.0 or greater.
- Fixed a bug that could cause a transactor to become unresponsive after waking from laptop sleep.

<a id="outline-container-0.9.4894"></a>

<a id="0.9.4894"></a>

## 0.9.4894 2014/08/26

<a id="text-0.9.4894"></a>

- New: transactor configuration setting to disable printing of credentials. Specify the boolean system property `datomic.printConnectionInfo` as `false` to disable. The default is true.

  Transactor properties documentation can be found at [System Properties](../../../05-operation/01-pro/11-system-properties/system-properties.md).

- Fixed bug that prevented nested map `db/id` overrides with string keys.

- Fixed a bug that could cause extra sessions to be created against Cassandra storage.

- This release optimizes the repair job introduced in 0.9.4880 to minimize its impact on live systems.

<a id="outline-container-0.9.4880"></a>

<a id="0.9.4880"></a>

## 0.9.4880 2014/08/21

<a id="text-0.9.4880"></a>

- Fixed bug where some indexed retractions are not enforced. This can cause old values to reappear, or uniqueness constraints to consider retracted values. Upgrading the transactor to this release will repair the problem during the next indexing job.
- Delay accepting V-only bindings in query ordering.
- Provide better error messages when backup/restore directory does not exist.
- Upgraded cassandra-driver-core to 2.0.3. This update fixes a bug in Cassandra that was causing it to leak file descriptors as described [here](https://issues.apache.org/jira/browse/CASSANDRA-6275).
- Added more logging around keys being written to storage.
- Added an error message when peers see no heartbeat.
- Added better error message when the value associated with the key is unavailable to be read from storage.
- Fixed bug where processes would sometimes prefer an old ident over a new one after a restart.
- SQL storage users can now configure the pool validation query via `datomic.sqlValidationQuery`, default is "SELECT 1".
- Re-enable metrics that were inadvertently disabled in 0.9.4815, e.g. `StorageGetMsec` and `StoragePutMsec`.
- Integrity validations added in newer versions of Datomic no longer prevent loading older non-compliant databases.

<a id="outline-container-0.9.4815"></a>

<a id="0.9.4815"></a>

## 0.9.4815 2014/08/13

<a id="text-0.9.4815"></a>

- Transactors now use the G1 garbage collector and require Java 7 or later. Peers continue to work with Java 6 or later.

- Database backups to S3 can now use '-encryption sse' to request server-side encryption.

- Better defaults and more configuration options for I/O utilization during backup and restore. [The Defaults](../../../05-operation/01-pro/08-backup-and-restore/backup-and-restore.md#performance) are now good for most scenarios.

- Updated AMIs across all regions with current Amazon Linux distributions and support for HVM-based instances.

- Added support for more Amazon instance types.

- Prevented race condition in `deleteDatabase` that could tie up a thread writing error messages in the log.

- Fixed bug where peers that were offline during a transaction would not see fulltext for the offline time until the next indexing job was completed.

- Better protection against retracting schema entities. If you encounter the following error:

  java.lang.IllegalArgumentException: :db.error/invalid-install-attribute at datomic.error-arg.invoke(error.clj:55) at datomic.db-install_attribute_hook.invoke(db.clj:1034) at datomic.db-run_hooks-fn\_\_3689.invoke(db.clj:1849)

  then you may have incorrectly retracted a schema entity. Contact support@cognitect.com for assistance recovering from this error.

- Protection against placing non-schema entities in the `:db.part/db` partition. If you see the following error message

  "Only schema components can be installed in partition :db.part/db"

  you will need to correct your program to create non-schema entities in `:db.part/user` or a partition you create.

- Fixed bug that prevented compilation of some `:require` forms in data functions.

<a id="outline-container-0.9.4766"></a>

<a id="0.9.4766"></a>

## 0.9.4766 2014/05/21

<a id="text-0.9.4766"></a>

- New built-in [query expressions](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md): `get-else`, `get-some`, `ground`, and `missing`.
- Added support for memcached-sasl, check [Caching](../../../05-operation/01-pro/09-memory-and-caching/memory-and-caching.md) for details.
- Allow lookup refs for V position in users of VAET index, including `:db.fn/retractEntity`.
- String representation for Connection no longer throws an exception if the connection is closed.

<a id="outline-container-0.9.4755"></a>

<a id="0.9.4755"></a>

## 0.9.4755 2014/04/23

<a id="text-0.9.4755"></a>

Re-enable input-bound rule predicates

<a id="outline-container-0.9.4752"></a>

<a id="0.9.4752"></a>

## 0.9.4752 2014/04/22

<a id="text-0.9.4752"></a>

- Fixes for parallelism in query function expressions.
- Fixes variable-less entity clauses.

<a id="outline-container-0.9.4745"></a>

<a id="0.9.4745"></a>

## 0.9.4745 2014/04/19

<a id="text-0.9.4745"></a>

Fixed bug where systems using adaptive indexing could become unavailable with the following exception on both transactors and peers:

java.lang.NullPointerException: null at datomic.db-find_last_tx.invoke(db.clj:1875) at datomic.db-db.invoke(db.clj:1885)

All users of adaptive indexing (0.9.4699 or greater) are strongly encouraged to upgrade to this release. Both transactors and peers need to be upgraded, but it's not necessary to upgrade them simultaneously.

<a id="outline-container-0.9.4724"></a>

<a id="0.9.4724"></a>

## 0.9.4724 2014/04/16

<a id="text-0.9.4724"></a>

This release upgrades the backup format to improve backup capacity against large databases. Datomic now stores backups using a subdirectory structure.

0.9.4724 can restore backups taken by previous versions of Datomic. However, previous versions of Datomic will not be able to restore newer backups.

<a id="outline-container-0.9.4718"></a>

<a id="0.9.4718"></a>

## 0.9.4718 2014/04/15

<a id="text-0.9.4718"></a>

More query optimizations. Keeps single-valued :in clauses at top.

<a id="outline-container-0.9.4714"></a>

<a id="0.9.4714"></a>

## 0.9.4714 2014/04/14

<a id="text-0.9.4714"></a>

Query optimizations.

<a id="outline-container-0.9.4707"></a>

<a id="0.9.4707"></a>

## 0.9.4707 2014/04/08

<a id="text-0.9.4707"></a>

- Fixed bug in peer object cache management that could result in OOM errors with large (\> 2GB) caches.
- Better error reporting for storage failures.
- Allow configuration of transactor KeyStore and TrustStore to facilitate encrypted communication with [Storages](../../../05-operation/01-pro/01-storage-services/storage-services.md).

<a id="outline-container-0.9.4699"></a>

<a id="0.9.4699"></a>

## 0.9.4699 2014/03/24

<a id="text-0.9.4699"></a>

- New feature: [adaptive indexing](https://blog.datomic.com/2014/03/datomic-adaptive-indexing.html). Check upgrading.
- Renamed metric: `AlarmTxStalledIndexing` is now `AlarmBackPressure`.
- Fixed default region in CloudFormation template.

<a id="outline-container-0.9.4609"></a>

<a id="0.9.4609"></a>

## 0.9.4609 2014/04/08

<a id="text-0.9.4609"></a>

- Upgraded HornetQ dependency to 2.3.17.Final. Due to changes in HornetQ, this release is incompatible with previous releases of Datomic. Both peers and transactors will need to be upgraded together.
- Updated Guava dependency to 16.0.1.

<a id="outline-container-0.9.4578"></a>

<a id="0.9.4578"></a>

## 0.9.4578 2014/03/24

<a id="text-0.9.4578"></a>

- Fixed bug where adding :db/index sometimes would not take effect. If you encounter this error, upgrade to this release then drop and read the index.
- Tighter validation around invalid schema changes.

<a id="outline-container-0.9.4572"></a>

<a id="0.9.4572"></a>

## 0.9.4572 2014/03/13

<a id="text-0.9.4572"></a>

- Prevent out-of-memory errors with very large indexing jobs, particularly those that are adding new AVET indexes.
- Release JDBC resources more aggressively when using SQL storage.

<a id="outline-container-0.9.4556"></a>

<a id="0.9.4556"></a>

## 0.9.4556 2014/03/05

<a id="text-0.9.4556"></a>

- New feature: [lookup refs](https://blog.datomic.com/2014/02/datomic-lookup-refs.html).
- Fixed bug where the transaction tempid would not resolve correctly when used only in value position.
- Fixed bug where peers could leak resources trying to connect to databases that have been deleted.
- More detailed error messages for some invalid transactions.
- Raise the enforced level of the total number of schema elements (such as attributes, partitions, and types) to be fewer than 2^20

------------------------------------------------------------------------

0.9.4532 includes an upgrade to the log format that requires simultaneous update of peers and transactors, and is not compatible with older versions, see below:

<a id="outline-container-0.9.4532"></a>

<a id="0.9.4532"></a>

## 0.9.4532 2014/02/24

<a id="text-0.9.4532"></a>

This release upgrades the database log to format version 2.

- All peers and transactors in a system must move together to this version or later.

- The transactor and peers are backward compatible with log version 1 Transactors will automatically upgrade database logs to version 2 when a database is used. The performance cost of this upgrade is negligible and upgrades can be performed against production systems.

- Older versions of the peer and transactor are -not- forward compatible with log version 2, and will report the following error:

  NullPointerException java.util.UUID.fromString

- Downgrading to log version 1 is possible. This release includes a command line tool that can be used to downgrade a database to log version 1:

  bin/datomic revert-to-log-version-1 {your-database-uri}

- Fixed bug where, after a transactor failure, Datomic processes could fail to start with a "Gap in data" exception.

- Fixed performance problem with *variance* and *sttdev* query aggregation functions.

- Limited thread use in query.

<a id="outline-container-0.9.4497"></a>

<a id="0.9.4497"></a>

## 0.9.4497 2014/02/07

<a id="text-0.9.4497"></a>

- Improvements to the REST client.
- Added a GettingStarted.groovy sample in the samples/seattle directory.
- Added SSL support for [Riak and Cassandra](../../../05-operation/01-pro/01-storage-services/storage-services.md).
- Improved script for launching transactor to allow for cleaner process management.
- Improved built-in Compare-and-Swap performance.
- Datomic now enforces the total number of schema elements (such as attributes, partitions, and types) to be fewer than 32k.

<a id="outline-container-0.9.4470"></a>

<a id="0.9.4470"></a>

## 0.9.4470 2014/01/29

<a id="text-0.9.4470"></a>

- New Feature: [alter schema](https://blog.datomic.com/2014/01/schema-alteration.html). This feature breaks compatibility with older versions. Once a schema alteration has been performed on a database, only connect peers and transactors running at least version 0.9.4470 to that database.
- New API: database.[attribute](../../../04-apis/02-peer-api-javadoc/interfaces/database/database.md) and [Attribute](../../../04-apis/02-peer-api-javadoc/interfaces/attribute/attribute.md).
- New APIs: [connection.syncIndex / syncSchema / syncExcise](../../../04-apis/02-peer-api-javadoc/interfaces/connection/connection.md).
- Datomic will now reject some unworkable memory settings, e.g. combinations of memory-index-max and object-cache-max that exceed 75% of JVM RAM.
- Added validation to prevent conflicting unique value assertions within a transaction.
- Fixed bug that prevented Datomic Console from working with Riak or Cassandra storage.
- Better logging for Riak storage.

<a id="outline-container-0.9.4384"></a>

<a id="0.9.4384"></a>

## 0.9.4384 2014/01/23

<a id="text-0.9.4384"></a>

Preliminary support for Cassandra [Storage](../../../05-operation/01-pro/01-storage-services/storage-services.md).

<a id="outline-container-0.9.4360"></a>

<a id="0.9.4360"></a>

## 0.9.4360 2013/12/18

<a id="text-0.9.4360"></a>

Used jarjar to move Datomic's use of Apache Lucene to package names that will not conflict with the application use of Lucene.

<a id="outline-container-0.9.4353"></a>

<a id="0.9.4353"></a>

## 0.9.4353 2013/12/12

<a id="text-0.9.4353"></a>

- Updated to aws-java-sdk 1.6.6.
- Datomic now supports DynamoDB Local as a development-time [Storage](../../../05-operation/01-pro/01-storage-services/storage-services.md) option.
- Datomic transactions now validate that tempids have a valid partition.
- Fixed bug where some transactions would timeout unnecessarily, even though the work was completed by the transactor.
- Fixed bug where fulltext queries did not find answers in the history database.

<a id="outline-container-0.9.4331"></a>

<a id="0.9.4331"></a>

## 0.9.4331 2013/12/09

<a id="text-0.9.4331"></a>

- Made transactor more robust against transient SQL storage connection failures.
- Fixed bug where transactor would log a spurious NPE from datomic.hornet during shutdown.

<a id="outline-container-0.9.4324"></a>

<a id="0.9.4324"></a>

## 0.9.4324 2013/11/27

<a id="text-0.9.4324"></a>

- Fixed a bug in IAM roles support that prevented automatic renewal of role credentials in one case.
- Fixed a bug in the build process that caused the 0.9.4314 version of the Console to be non-operational.

<a id="outline-container-0.9.4314"></a>

<a id="0.9.4314"></a>

## 0.9.4314 2013/11/25

<a id="text-0.9.4314"></a>

- IAM roles are now the preferred way to supply credentials when running Datomic in AWS. See [Storage](../../../05-operation/01-pro/01-storage-services/storage-services.md) to configure a new transactor using IAM roles. Check [migrate-to-roles](../../../10-resources/06-legacy-resources/04-migrate-to-roles/migrate-to-roles.md) to migrate an existing Datomic configuration to use IAM roles.
- The transactor now supports a mechanism for integrating different monitoring services, see the 'Custom Monitoring' section of [monitoring](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md).
- Updated Riak client to 1.4.2.
- Cloudwatch and custom monitoring now report the count of `RemotePeers`.

<a id="outline-container-0.8.4270"></a>

<a id="0.8.4270"></a>

## 0.8.4270 2013/11/18

<a id="text-0.8.4270"></a>

- Fixed bug where large excisions could prevent subsequent storage garbage collection.
- Fixed bug where Datomic Pro eval keys did not have access to HA.
- Datomic now verifies Lucene major version without using package reflection (fixes inability to uberjar 4260).
- Updated Fressian dependency to 0.6.5.
- Better error message on nil input to query.

<a id="outline-container-0.8.4260"></a>

<a id="0.8.4260"></a>

## 0.8.4260 2013/11/07

<a id="text-0.8.4260"></a>

- Make sure Util.read preloads schema-reading helpers, so that schemas can be read before touching a database.
- Fixed bug in connection pool validator for Oracle SQL storage.

<a id="outline-container-0.8.4254"></a>

<a id="0.8.4254"></a>

## 0.8.4254 2013/10/29

<a id="text-0.8.4254"></a>

- New: [Datomic Console](../../../10-resources/03-datomic-pro-console/datomic-pro-console.md).
- More consistent use of error handling throughout API.
- Quicker detection of transactor disconnects, reported to peers via exceptions in transaction futures and sync futures.
- Fixed bug in 4215, 4218 that caused `IllegalStateException` when calling `Util.read`.
- Corrected sa-east-1 transactor AMI ID.

<a id="outline-container-0.8.4218"></a>

<a id="0.8.4218"></a>

## 0.8.4218 2013/10/11

<a id="text-0.8.4218"></a>

Fixed bug where transaction promises could be garbage collected before a transaction completes, preventing `ListenableFuture` callbacks from firing.

<a id="outline-container-0.8.4215"></a>

<a id="0.8.4215"></a>

## 0.8.4215 2013/10/01

<a id="text-0.8.4215"></a>

Improved redundancy elimination. If a transaction presents a datom that is identical (except for tx) to an existing datom, that datom will not be added to the log.

<a id="outline-container-0.8.4159"></a>

<a id="0.8.4159"></a>

## 0.8.4159 2013/09/10

<a id="text-0.8.4159"></a>

- Updated aws-java-sdk dependency to 1.5.5, discontinued using jets3t.
- Reduced background thread usage in query.
- Transactions now convert doubles to floats when attribute schema requires floats.
- Transactor heartbeat is now more robust in the face of transient failures writing to storage.

<a id="outline-container-0.8.4143"></a>

<a id="0.8.4143"></a>

## 0.8.4143 2013/08/22

<a id="text-0.8.4143"></a>

- `:db/noHistory` is now respected by indexer.
- More precise docstring for `:db/noHistory`.

<a id="outline-container-0.8.4138"></a>

<a id="0.8.4138"></a>

## 0.8.4138 2013/08/14

<a id="text-0.8.4138"></a>

- Improved transactor performance, specifically around memory usage and GC pauses. This includes improved memory efficiency in indexing, and a new set of GC flags in bin/transactor.
- Fixed bug where queries with constants in V position could return too many results.
- Transactor does more useful logging at the INFO level, so there should be less need to modify the logging configuration.

<a id="outline-container-0.8.4122"></a>

<a id="0.8.4122"></a>

## 0.8.4122 2013/08/03

<a id="text-0.8.4122"></a>

- New: API for accessing the [log](../../../04-apis/09-log-api/log-api.md).
- Return correct result from REST avet datoms call when neither start nor end are provided.
- Eliminate spurious file bin/logback-test.xml that was incorrectly included in 0.8.4111.

<a id="outline-container-0.8.4111"></a>

<a id="0.8.4111"></a>

## 0.8.4111 2013/07/31

<a id="text-0.8.4111"></a>

- New: memory settings for the transactor must be explicitly specified in the transactor properties file. There are no default settings, so existing transactor property files that lack these settings will no longer work. The transactor properties sample files include three complete examples, representing ongoing usage, one-time imports, and constrained-memory usage during development.
- New: stricter validation of datoms within a single transaction, preventing duplication of the same datom and multiple assertions of cardinality-one attributes. This will cause transactions that would formerly have succeeded to fail with a validation error.
- New: the transactor and peer now require Clojure 1.5.1 or greater.
- New: peer configuration setting for peer/transactor connection timeout. Specify system property `datomic.peerConnectionTTLMsec` in milliseconds. Default and minimum are both 10000.
- New: Reverse attribute lookups from an entity are returned as sets.
- Transactors are now more robust in the face of transient errors writing to storage.
- `touch` now works correctly for component entities that have `:db/ident`.
- Better error messages for invalid S3 backup URL, attempting to back up a database that does not exist.
- Updated jetty dependencies (used in REST server).

<a id="outline-container-0.8.4020.26"></a>

<a id="0.8.4020.26"></a>

## 0.8.4020.26 2013/07/09

<a id="text-0.8.4020.26"></a>

- Fixed bug that prevented zero-argument data functions in Java.
- Fixed bug where peers have trouble connecting when already-connected peers are producing a heavy write load.

<a id="outline-container-0.8.4020.24"></a>

<a id="0.8.4020.24"></a>

## 0.8.4020.24 2013/07/01

<a id="text-0.8.4020.24"></a>

- Fixed bug in 0.8.4020 where nested collections of preexisting entity ids were incorrectly rejected by the transactor, with a "Unable to interpret … as a reference target" message.
- Fixed bug in 0.8.4020 where use of a transaction entity in value position only leads to background indexing failure on the transactor.

<a id="outline-container-0.8.4020"></a>

<a id="0.8.4020"></a>

## 0.8.4020 2013/06/19

<a id="text-0.8.4020"></a>

- [Component entities can now be created as nested maps in transaction data](https://blog.datomic.com/2013/06/component-entities.html).
- Tightened peer HornetQ timeout for faster failover.
- Allow sets as an alternative to lists when specifying values for a cardinality-many attribute in transaction data.
- Fixed bug: Allow the transaction entity to appear in value position only in transaction data.
- Fixed bug: Prevent excessive memory use that would occur before rejecting an invalid transaction that attempts to `db.fn/retractEntity` nil.

<a id="outline-container-0.8.4007"></a>

<a id="0.8.4007"></a>

## 0.8.4007 2013/06/12

<a id="text-0.8.4007"></a>

- Updated several library dependencies to more recent versions: aws, guava, h2, logback, netty, and slf4j.
- Better `toString` representations for objects likely to be encountered in shell (e.g. groovysh) sessions.

<a id="outline-container-0.8.3993"></a>

<a id="0.8.3993"></a>

## 0.8.3993 2013/06/03

<a id="text-0.8.3993"></a>

- Increased parallelism in query.
- New API: [connection.sync](https://blog.datomic.com/2013/06/sync.html.).
- Connection.db now returns a database immediately, even if the transactor is unavailable.
- Improved peer recovery time during [HA](../../../05-operation/01-pro/07-high-availability/high-availability.md) failover.

<a id="outline-container-0.8.3971"></a>

<a id="0.8.3971"></a>

## 0.8.3971 2013/05/23

<a id="text-0.8.3971"></a>

- Fixed bug where some active log segments are marked as garbage, which can result in log corruption after a call to `gcStorage`. Moving to this release is strongly advised.
- Improved CloudWatch metric: `IndexWrites` is now reported once per indexing job, making it easier to reason about per-index-job load.
- New CloudWatch metric: `TransactionBatch` tracks the number of transactions batched into a single write to the log.
- New CloudWatch metric: `MemoryIndexFillMsec` reports an estimate of the time to fill the memory index, given the current write load.

<a id="outline-container-0.8.3970"></a>

<a id="0.8.3970"></a>

## 0.8.3970 2013/05/23

<a id="text-0.8.3970"></a>

(Do not use this release).

<a id="outline-container-0.8.3960"></a>

<a id="0.8.3960"></a>

## 0.8.3960 2013/05/20

<a id="text-0.8.3960"></a>

Fixed a bug where indexing jobs could fail for fulltext attributes.

<a id="outline-container-0.8.3952"></a>

<a id="0.8.3952"></a>

## 0.8.3952 2013/05/16

<a id="text-0.8.3952"></a>

- Fixed bug where HA transactor pool can become stuck and no transactor can start. All HA users should adopt this release as soon as possible.
- Mark log segments as garbage after excision. Note that .gcStorage is still a necessary separate step.
- Improved efficiency in writing transaction logs.
- Quickly report pending transactions failed if the transactor connection is lost.

<a id="outline-container-0.8.3941"></a>

<a id="0.8.3941"></a>

## 0.8.3941 2013/05/10

<a id="text-0.8.3941"></a>

[Excision](../../../05-operation/01-pro/15-excision/excision.md).

<a id="outline-container-0.8.3899"></a>

<a id="0.8.3899"></a>

## 0.8.3899 2013/05/08

<a id="text-0.8.3899"></a>

Fixed bug where background index creation could fail to trigger in systems running multiple databases, eventually resulting in the need to restart transactor.

<a id="outline-container-0.8.3895"></a>

<a id="0.8.3895"></a>

## 0.8.3895 2013/04/26

<a id="text-0.8.3895"></a>

- Allow explicit `h2-port` and `h2-web-port` specification in the query string for free and dev protocols.
- Fixed bug where Hornet usage of file system did not respect `data-dir` transactor property.
- Upgraded to netty 3.6.3.Final.

<a id="outline-container-0.8.3889"></a>

<a id="0.8.3889"></a>

## 0.8.3889 2013/04/14

<a id="text-0.8.3889"></a>

- Enhanced SQL storage to work with a wider set of databases, including Oracle.
- Fixed bug where, after a cold restart of transactor, peer could attempt transactions that would arrive before the transactor was ready and timeout.
- Fixed bug that caused "Database deleted" error when deleting and recreating databases in development.
- Fixed bug in CloudFormation template creation that required explicit setting of `java-opts` property, even when defaults acceptable.
- Added missing AWS instance sizes to CloudFormation template generator.
- Upgraded to AWS Java SDK 1.4.1.

<a id="outline-container-0.8.3862"></a>

<a id="0.8.3862"></a>

## 0.8.3862 2013/03/29

<a id="text-0.8.3862"></a>

Fixed incorrect validation introduced in 0.8.3861 that prevented asserting the attribute value `false`.

<a id="outline-container-0.8.3861"></a>

<a id="0.8.3861"></a>

## 0.8.3861 2013/03/27

<a id="text-0.8.3861"></a>

- New API `Peer.shutdown`.
- New API `Connection.release`.
- Fixed spurious error after heartbeat failure on transactor.
- New: positional destructuring of datoms (Clojure API).
- Fixed performance problems in `:db.fn/retractEntity`.

<a id="outline-container-0.8.3848"></a>

<a id="0.8.3848"></a>

## 0.8.3848 2013/03/13

<a id="text-0.8.3848"></a>

- Fixed `Entity.keySet` to return a set of strings.
- Better naming convention for log rotation: `{bucket}/{system-root}/{status}/{time-status-reached}`, where status is "active" or "standby".

<a id="outline-container-0.8.3843"></a>

<a id="0.8.3843"></a>

## 0.8.3843 2013/03/12

<a id="text-0.8.3843"></a>

- Fixed bug where invalid (non-string) fulltext attribute prevents log ingest.
- New `seekDatoms` and `entidAt` APIs.
- `Heartbeat` and `HeartMonitor` metrics have been replaced by the more informative `HeartbeatMsec` and `HeartMonitorMsec` metrics.
- New `java-opts` option in transactor properties.

<a id="outline-container-0.8.3826"></a>

<a id="0.8.3826"></a>

## 0.8.3826 2013/02/25

<a id="text-0.8.3826"></a>

- Improved resilience to transient errors in backup/restore.
- Upgrade to netty 3.6.0.Final, fixing SSL race condition that could prevent peers from connecting.
- New `java-xmx` setting in CloudFormation template makes JVM heap configuration more evident.
- Deprecated `StorageBackoff` metric in favor of a more explicit `StorageGetBackoffMsec` and `StoragePutBackoffMsec` metrics.

<a id="outline-container-0.8.3814"></a>

<a id="0.8.3814"></a>

## 0.8.3814 2013/02/14

<a id="text-0.8.3814"></a>

- Prevent aggressive timeout in Peer.connect that could occur when connecting to cold transactor + slow log ingest.
- Allowed peers to ingest log in parallel with ingest on a cold transactor.
- Added LogIngestMsec and LogIngestBytes Cloudwatch metrics. See [monitoring](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md) for more on metrics.
- Renamed system property `datomic.objectCacheBytes` to `datomic.objectCacheMax` for consistency with other property names. See [capacity](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md) for more on capacity-related properties.

<a id="outline-container-0.8.3803"></a>

<a id="0.8.3803"></a>

## 0.8.3803 2013/02/12

<a id="text-0.8.3803"></a>

- Fixed bug that caused intermittent deadlock communicating with storage.
- Reduced memory usage during backup and restore.

<a id="outline-container-0.8.3789"></a>

<a id="0.8.3789"></a>

## 0.8.3789 2013/02/02

<a id="text-0.8.3789"></a>

- Made default JVM heap sizes for AMI appliances more conservative.
- Set transactor instance name based on CloudFormation template name.
- Include command-line utility JARs that were inadvertently omitted in 0.8.3784.

<a id="outline-container-0.8.3784"></a>

<a id="0.8.3784"></a>

## 0.8.3784 2013/02/01

<a id="text-0.8.3784"></a>

- Improved indexing performance: lower memory use on the transactor, and higher transaction throughput during indexing jobs.
- New [deployment documentation](../../../05-operation/01-pro/04-datomic-deployment/datomic-deployment.md).
- New transactor memory setting `memory-index-threshold`, and expanded documentation at [capacity](../../../05-operation/01-pro/05-capacity-planning/capacity-planning.md).
- Overhauled the metrics reported by the transactor. Learn about the new metrics at [monitoring](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md).
- Fixed bug that caused incomplete garbage collection of storage on DynamoDB.

<a id="outline-container-0.8.3767"></a>

<a id="0.8.3767"></a>

## 0.8.3767 2013/01/23

<a id="text-0.8.3767"></a>

- Fixed bug where deleting a database could cause subsequent indexing jobs of other databases to fail with "No implementation of method: :queue-database-index …"
- New `Alarm` metric is fired whenever the transactor encounters a problem that requires manual intervention.
- Improved indexing performance, particularly for larger strings and binary values.

<a id="outline-container-0.8.3731"></a>

<a id="0.8.3731"></a>

## 0.8.3731 2013/01/09

<a id="text-0.8.3731"></a>

- Improved resilience in the face of unreliable or throttled storage.
- Added write-concurrency setting to the transactor properties file, which can be used to limit the number of concurrent writes to storage.
- Added StorageBackoff metric, which records the amount of time spent backing off and waiting for storage.
- Fixed bug where fulltext queries would sometimes seek off the end of an index and throw IOException.

------------------------------------------------------------------------

<a id="outline-container-0.8.3705"></a>

<a id="0.8.3705"></a>

## 0.8.3705 - Breaking change to peer/transactor communication - 2013/01/09

<a id="text-0.8.3705"></a>

Upgrade to HornetQ 2.2.21. This change breaks compatibility with older versions, so peers and transactors must be upgraded together.

<a id="outline-container-0.8.3704"></a>

<a id="0.8.3704"></a>

## 0.8.3704 2013/01/03

<a id="text-0.8.3704"></a>

Fixed bug in HA support. HA does not work with the three previous releases (3692, 3664, 3655). If you are running a standby transactor for HA, make sure to upgrade to this release.

<a id="outline-container-0.8.3692"></a>

<a id="0.8.3692"></a>

## 0.8.3692 2012/12/28

<a id="text-0.8.3692"></a>

- Fixed bug where restore would restore to a version other than the most recent in the backup storage.
- Improved backup CLI: You can now `list-backups` to see different points in time (t) that are backed up to a storage, and pass a `t` argument to `restore-db` to restore from a version other than the most recent in the backup storage.
- Fixed bug: all transaction errors now throw exceptions consistent with the API documentation. (Some errors had been thrown early, on transact, rather than on dereferencing the transaction future.)
- Fixed a bug where a portion of the history index was not considered by the `asOf` database filter.
- Fixed bug where, under unusual circumstances, datoms could reappear in the present index, even though they had been retracted.
- Performance optimization: Peer cache now reads ahead on indexes.
- Updated to spymemcached 2.8.9.
- Fixed bug where retraction of a nonexistent fulltext attribute value could cause subsequent indexing jobs to fail.
- Fixed a bug that could prevent connection to a database after a cycle of create / backup / delete / restore.

<a id="outline-container-0.8.3664"></a>

<a id="0.8.3664"></a>

## 0.8.3664 2012/12/15

<a id="text-0.8.3664"></a>

Added gap-detection validation when reading log on startup. Operating with a gap, while not resulting in loss of data, can cause violations of uniqueness and cardinality constraints. Users on releases prior to 0.8.3664 are strongly encouraged to move to 0.8.3664 or later as soon as possible.

<a id="outline-container-0.8.3655"></a>

<a id="0.8.3655"></a>

## 0.8.3655 2012/12/12

<a id="text-0.8.3655"></a>

- Fixed bug where entities could have more than one :db/fn attribute.
- Fixed bug in log loading where a window of data could be invisible on restart, even though that data is present in the log.

<a id="outline-container-0.8.3646"></a>

<a id="0.8.3646"></a>

## 0.8.3646 2012/12/09

<a id="text-0.8.3646"></a>

- Fixed bug where database indexing fails after a backup/restore cycle.
- Fixed bug in Clojure API where transaction futures sometimes would return (rather than throw) an exception.
- Fixed bug in Java API where transaction futures would occasionally return an object that is not the documented map.
- Better error reporting for some kinds of invalid queries.
- Alpha support for CORS in the REST service. Note that the bin/rest args have changed. See [rest](../../../04-apis/10-rest-api/rest-api.md)\] for details.

<a id="outline-container-0.8.3627"></a>

<a id="0.8.3627"></a>

## 0.8.3627 2012/11/27

<a id="text-0.8.3627"></a>

- Fixed bug where the first restore of a database to a new storage did not include the most recent data, even though that data was present in the backup. (Subsequent restores were unaffected).
- Queries now take a :with clause, to specify variables to be kept in the aggregation set but not returned.
- Database.filter predicates now take two arguments: The unfiltered Database value and the Datom.
- You can now retrieve the Database that is the basis of an entity with Entity.db.
- You can now install a release of Datomic Pro into your local Maven repository with bin/maven-install.

<a id="outline-container-0.8.3619"></a>

<a id="0.8.3619"></a>

## 0.8.3619 2012/11/21

<a id="text-0.8.3619"></a>

- Alpha release of Database.filter, which returns a value of the database filtered to contain only the datoms satisfying a predicate.
- New AWS metric: IndexWrites.
- Peers no longer need to include a Datomic-specific Maven repository, as [Fressian](https://github.com/Datomic/fressian) is now available from Maven Central and clojars.

<a id="outline-container-0.8.3611"></a>

<a id="0.8.3611"></a>

## 0.8.3611 2012/11/19

<a id="text-0.8.3611"></a>

- Added memory-index-max setting to allow higher throughput for e.g. import jobs.
- Bugfix: fixed bug that prevents indexing jobs from completing with some usages of fulltext attributes.
- Added additional AWS instance types to AMI setup scripts.
- Bugfix: Cloudformation generation now respects aws-autoscaling-group-size setting.
- Fixed broken query example in GettingStarted.java.
- Fixed docstring for datomic.api/with.

<a id="outline-container-0.8.3599"></a>

<a id="0.8.3599"></a>

## 0.8.3599 2012/11/09

<a id="text-0.8.3599"></a>

- Fixed "No suitable driver" error with dev: and free: protocols in some versions of Tomcat.
- Updated bin/datomic `delete-cf-stack` command to work with multiregion AWS support.

<a id="outline-container-0.8.3595"></a>

<a id="0.8.3595"></a>

## 0.8.3595 2012/11/04

<a id="text-0.8.3595"></a>

- Fixed bug that prevented building queries from Java data.
- Transactor AMIs are now available in all AWS regions that support DynamoDB: us-east-1, us-west-1, us-west-2, eu-west-1, ap-northeast-1. and ap-southeast-1.
- Breaking change: CloudFormation properties file has a new required key `aws-region`, allowing you to select the AWS region where a transactor will run.

<a id="outline-container-0.8.3591"></a>

<a id="0.8.3591"></a>

## 0.8.3591 2012/11/02

<a id="text-0.8.3591"></a>

- Preliminary support for Couchbase and Riak storages.
- Breaking change: DynamoDB storage is now region-aware. URIs include the AWS region as a first component. The transactor properties file has a new mandatory property `aws-dynamodb-region`.
- Breaking change: CloudWatch monitoring is now region-aware. If using CloudWatch, you must set `aws-cloudwatch-region` in the transactor properties.
- Transactions now return a datomic.ListenableFuture, allowing a callback on transaction completion.
- Fixed bug in the command line entry point for restoring a database, which was defaulting to the most ancient backup instead of the most recent.
- Fixed bug that prevented restoring to a `dev:` or `free:` storage in some situations.

<a id="outline-container-0.8.3561"></a>

<a id="0.8.3561"></a>

## 0.8.3561 2012/10/23

<a id="text-0.8.3561"></a>

- Breaking change: db.with() now returns a map like the map returned from Connection.transact().
- Incompatible and unsupported schema changes now throw exceptions.
- Better error messages when calling a query with bad or missing inputs.
- Documented system properties.

<a id="outline-container-0.8.3551"></a>

<a id="0.8.3551"></a>

## 0.8.3551 2012/10/10

<a id="text-0.8.3551"></a>

Fixes to alpha aggregation functions.

<a id="outline-container-0.8.3546"></a>

<a id="0.8.3546"></a>

## 0.8.3546 2012/10/09

<a id="text-0.8.3546"></a>

Alpha support for aggregation functions in query.

<a id="outline-container-0.8.3538"></a>

<a id="0.8.3538"></a>

## 0.8.3538 2012/09/21

<a id="text-0.8.3538"></a>

- Fixed bug where variables bound by a query :in clause were not seen as bound inside rules.
- Added `invoke` API for invoking database functions.

<a id="outline-container-0.8.3524"></a>

<a id="0.8.3524"></a>

## 0.8.3524 2012/09/16

<a id="text-0.8.3524"></a>

Fixed bug that caused temporary ids to read incorrectly in transaction functions, causing transactions to fail.

<a id="outline-container-0.8.3520"></a>

<a id="0.8.3520"></a>

## 0.8.3520 2012/09/14

<a id="text-0.8.3520"></a>

- Fixed but that prevented the catalog page from loading on REST service when running against a persistent storage.
- Enhancements to REST documentation.

<a id="outline-container-0.8.3511"></a>

<a id="0.8.3511"></a>

## 0.8.3511 2012/09/14

<a id="text-0.8.3511"></a>

The REST service is now its documentation. Just point a browser at the root of the server:port on which you started the service. Note that the "web app" that results **is** the service. It is not an app built on the service, nor a set of documentation pages about the service. The URIs, query params, and POST data are the same ones you will use when accessing the service programmatically.

<a id="outline-container-0.8.3488"></a>

<a id="0.8.3488"></a>

## 0.8.3488 2012/09/06

<a id="text-0.8.3488"></a>

Initial version of REST service.

<a id="outline-container-0.8.3479"></a>

<a id="0.8.3479"></a>

## 0.8.3479 2012/09/04

<a id="text-0.8.3479"></a>

New API: `Entity.touch` touches all attributes of an entity, and any component entities recursively.

<a id="outline-container-0.8.3470"></a>

<a id="0.8.3470"></a>

## 0.8.3470 2012/08/31

<a id="text-0.8.3470"></a>

- Fixed bug where some recursive queries return incorrect results.
- Fixed bug in command-line entry point for restoring from S3.

<a id="outline-container-0.8.3460"></a>

<a id="0.8.3460"></a>

## 0.8.3460 2012/08/29

<a id="text-0.8.3460"></a>

- Fixed bug where peers could continue to interact with connections to deleted databases.
- Fixed query bug where constants in queries were not correctly joined with answers.
- Fixed directory structure in JAR file format, which was causing problems for some tools.
- Report serialization errors back to data function callers, rather than make them wait for transaction timeout.
- Better error messages for some common URI misspellings.

<a id="outline-container-0.8.3438"></a>

<a id="0.8.3438"></a>

## 0.8.3438 2012/08/22

<a id="text-0.8.3438"></a>

Fixed bug in :db/txInstant that prevented backdating before db was created.

<a id="outline-container-0.8.3435"></a>

<a id="0.8.3435"></a>

## 0.8.3435 2012/08/21

<a id="text-0.8.3435"></a>

- New API: `Peer.resolveTempid` provides the actual database ids corresponding to temporary ids submitted in a transaction.
- Changed API: you can now explicitly specify the :db/txInstant of a transaction. This facilitates backdating transactions during data imports.
- changed API: transaction futures now return a map with DB_BEFORE, DB_AFTER, TX_DATA and TEMPIDS.
- Changed API: transaction report queues now report the same data as calls to `Connection.transact`
- Changed API: transaction report TX_DATA now includes retractions in addition to assertions.
- New API: `Database.basisT` returns the t of the most recent transaction
- Bugfix: fixed bug that prevented AWS provisioning scripts from running

<a id="outline-container-0.8.3423"></a>

<a id="0.8.3423"></a>

## 0.8.3423 2012/08/16

<a id="text-0.8.3423"></a>

- New API: `database.history` returns a value of a database containing all assertions and retractions across time.
- New API: `database.isHistory` returns true if database is a history database.
- New API: `datom.added` returns true if datom is added, false if retracted.
- Changed API: the Datom relation in a query now exposes a fifth component, containing a boolean that is true for adds, false for retracts.
- Changed API: removed `Index` class, range capability now available directly from `Database`.
- Bugfix: calling `keys` on an entity with no current attributes no longer throws NPE.
- Updated to use the recent (12.0.1) version of Google Guava.
- When a peer calls `deleteDatabase`, shut down that peer's connection.

<a id="outline-container-0.8.3397"></a>

<a id="0.8.3397"></a>

## 0.8.3397 2012/08/07

<a id="text-0.8.3397"></a>

- Fixed bug where some recursive queries returned partial results.
- Simplified license key install: pro license keys are installed via a `license-key` entry in the transactor properties file.
- Connection catalog lookup is cached, so it is inexpensive to call `Peer.connect` as often as you like.
- Improved fulltext indexing and query performance.

<a id="outline-container-0.8.3372"></a>

<a id="0.8.3372"></a>

## 0.8.3372 2012/07/31

<a id="text-0.8.3372"></a>

- Changed API: query clauses are considered in order.
- Changed API: when navigating entities, references to entities that have a `db/ident` return that ident, instead of the entity.
- New API: `database.index` supports range requests.
- Fixed broken dependency that prevented datomic-pro peer jar from working with DynamoDB.
- New API: `peer.part` function returns the partition of an entity id.
- New API: `peer.toTx` and `Peer.toT` conversion functions.
- Entity equality is ref-like, i.e. identity-based.
- Eliminated resource leaks that affected multiple databases and some failover scenarios.

<a id="outline-container-0.8.3343"></a>

<a id="0.8.3343"></a>

## 0.8.3343 2012/07/25

<a id="text-0.8.3343"></a>

- Added API entry points for generating semi-sequential UUIDs, a.k.a squuids.
- Use correct maven artifact ids: `datomic-free` for Datomic Free Edition, and `datomic-pro` for Datomic Pro Edition.
- Fixed bug where queries could see retracted values of a cardinality-many attribute.

<a id="outline-container-0.8.3335"></a>

<a id="0.8.3335"></a>

## 0.8.3335 2012/07/24

<a id="text-0.8.3335"></a>

Initial public release of Datomic free edition and Datomic Pro edition.
