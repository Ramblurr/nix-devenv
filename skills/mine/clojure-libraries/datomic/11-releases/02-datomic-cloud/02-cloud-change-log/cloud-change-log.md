<a id="content"></a>

<a id="datomic-cloud-change-log"></a>

# Datomic Cloud Change Log

<a id="outline-container-1217-9399"></a>

<a id="1217-9399"></a>

## 2026/02/17 - 1217-9399

<a id="text-1217-9399"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Performance: Improve indexing performance, reduce I/O in large databases
- Fix: Indexing slowly leaks garbage segments in storage which are unrecoverable by datomic garbage collection
- Upgrade The AMI is now based on the [2026/01/20](https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.10.20260120.html) version of the Linux 2023 base AMI.

<a id="outline-container-ion-dev-1-0-352"></a>

<a id="ion-dev-1-0-352"></a>

## 2026/02/17 - 1.0.352 - Ion-Dev

<a id="text-ion-dev-1-0-352"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Upgrade: org.clojure/tools.deps.alpha to org.clojure/tools.deps 0.24.1523
- Updated dep list for Datomic Cloud 1217-9399

<a id="outline-container-1172-9392"></a>

<a id="1172-9392"></a>

## 2025/08/12 - 1172-9392

<a id="text-1172-9392"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Fix: Prevent a problem where in rare situations indexing jobs can fail to progress indefinitely.

<a id="outline-container-ion-dev-1-0-326"></a>

<a id="ion-dev-1-0-326"></a>

## 2025/06/17 - 1.0.326 - Ion-Dev

<a id="text-ion-dev-1-0-326"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Updated dep list for Datomic Cloud 1171-9390

<a id="outline-container-1171-9390"></a>

<a id="1171-9390"></a>

## 2025/06/17 - 1171-9390

<a id="text-1171-9390"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Performance: Reduce memory usage in large databases
- Performance: Improve indexing performance, reduce I/O in large databases
- Upgraded org.clojure/core.async to 1.8.741
- Upgrade CFT Lambda Runtime to nodejs22.x. See: <https://aws.amazon.com/blogs/compute/node-js-22-runtime-now-available-in-aws-lambda/>

<a id="outline-container-1162-9380"></a>

<a id="1162-9380"></a>

## 2025/04/16 - 1162-9380

<a id="text-1162-9380"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Performance: Reduce memory required to calculate db-stats.
- Performance: Reduce memory required to calculate index-metrics.
- Performance: Improved operation throughput on primary compute instances larger than `t3.small`.
- Performance: Reduce memory required for indexing.

<a id="outline-container-client-1-0-131"></a>

<a id="client-1-0-131"></a>

## 2025/02/03 1.0.131 - Client-Cloud Update

<a id="text-client-1-0-131"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Updated client-cloud to 1.0.139 to address reflection warnings introduced with JDK19

<a id="outline-container-1126-9340"></a>

<a id="1126-9340"></a>

## 2024/08/23 - 1126-9340

<a id="text-1126-9340"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Upgraded Clojure to 1.11.4. See <https://clojure.org/news/2024/08/03/clojure-1-11-4>

<a id="outline-container-1125-9339"></a>

<a id="1125-9339"></a>

## 2024/07/11 - 1125-9339

<a id="text-1125-9339"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Feature: tx-stats. See [tx stats](../../../04-apis/13-tx-stats/tx-stats.md)
- Performance: Improve performance in transactions and calls to d/with by prefetching reads. Config option datomic.prefetchConcurrency limits the number of concurrent prefetches. See [system properties](../../../05-operation/01-pro/11-system-properties/system-properties.md)
- Fix: Ensure datoms are virtual and are no longer added to the log.
- Upgraded com.datomic/client-cloud to 1.0.130
- Upgraded com.datomic/ion to 1.0.71

<a id="outline-container-client-1-0-130"></a>

<a id="client-1-0-130"></a>

## 2024/07/11 1.0.130 - Client-Cloud Update

<a id="text-client-1-0-130"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Upgraded com.cognitect/s3-creds to 1.0.31

<a id="outline-container-ion-71"></a>

<a id="ion-71"></a>

## 2024/07/11 1.0.71 - Ion

<a id="text-ion-71"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

- Upgraded com.cognitect/transit-clj to 1.0.333

<a id="outline-container-ion-dev-1-0-325"></a>

<a id="ion-dev-1-0-325"></a>

## 2024/07/11 - 1.0.325 - Ion-Dev

<a id="text-ion-dev-1-0-325"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Updated dep list for Datomic Cloud 1125-9339

<a id="outline-container-client-1-0-125"></a>

<a id="client-1-0-125"></a>

## 2024/02/12 1.0.125 - Client-Cloud Update

<a id="text-client-1-0-125"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Fix: correctly deserialize URIs to java.net.URI

<a id="outline-container-1102-9309"></a>

<a id="1102-9309"></a>

## 2023/12/20 - 1102-9309

<a id="text-1102-9309"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Enhancement: migrate CloudFormation templates to use AutoScalingGroup LaunchTemplate instead of the deprecated LaunchConfiguration.
- Fix: pull expression could return true when supplying a :default for a boolean attribute.
- Fix: regression introduced in 990-9202 that could cause a database with blank keyword idents to fail to load.
- Performance: replace BufferedInputStream with an unsynchronized stream.
- Upgrade CFT Lambda Runtime to nodejs18.x.
- Upgraded core.async to 1.6.681.
- Upgraded commons-codec to 1.16.0.
- Upgraded aws-java-sdk-bundle to 1.12.564.
- Upgraded memcache-asg-java-client to 1.1.0.36.
- Upgraded http-client to 1.0.126.
- Upgraded transit-clj to 1.0.333.
- Upgraded client-cloud to 1.0.124.
- Upgraded fressian to 0.6.8.
- Upgraded guava to 32.0.1-jre.
- Upgraded jul-to-slf4j to 1.7.36.
- Upgraded log4j-over-slf4j to 1.7.36.
- Upgraded jcl-over-slf4j to 1.7.36.
- Upgraded tools.namespace to 1.4.4.
- Upgrade The AMI is now based on the [2023/10/16](https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.2.20231016.html) version of the Linux 2023 base AMI.

<a id="outline-container-client-1-0-124"></a>

<a id="client-1-0-124"></a>

## 2023/12/20 1.0.124 - Client-Cloud Update

<a id="text-client-1-0-124"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Upgraded core.async to 1.6.681.
- Upgraded commons-codec to 1.16.0.
- Upgraded aws-java-sdk-bundle to 1.12.564.
- Upgraded http-client to 1.0.126.
- Upgraded org.eclipse.jetty/jetty-\* to 9.4.52.v20230823.
- Upgraded org.msgpack/msgpack to 0.6.12.

<a id="outline-container-ion-68"></a>

<a id="ion-68"></a>

## 2023/12/20 1.0.68 - Ion

<a id="text-ion-68"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

Upgraded aws-java-sdk-ssm to 1.12.564.

<a id="outline-container-ion-dev-1-0-316"></a>

<a id="ion-dev-1-0-316"></a>

## 2023/12/20 - 1.0.316 - Ion-Dev

<a id="text-ion-dev-1-0-316"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Upgraded Clojure to 1.11.1.
- Upgraded AWS Java SDK to 1.12.564.
- Upgraded org.yaml/snakeyaml to 2.2.

<a id="outline-container-1067-9276"></a>

<a id="1067-9276"></a>

## 2023/10/09 - 1067-9276

<a id="text-1067-9276"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Performance: reduced resources required by indexing.
- Performance: improved EFS IOPS usage.
- Performance: indexing is more aggressive in removing `:db/noHistory` datoms.
- Performance: improved fressian read.
- Upgrade: NodeJS used in Lambdas upgraded to 16.x.
- Upgrade: Java on compute nodes upgraded to Java 17.
- Upgrade The AMI is now based on the [2023/08/09 version](https://docs.aws.amazon.com/linux/al2023/release-notes/relnotes-2023.1.20230809.html) of the Linux 2023 base AMI.
- Enhancement: use latest [AWS recommendations](https://docs.aws.amazon.com/efs/latest/ug/mounting-fs-nfs-mount-settings.html) for mounting EFS Volumes.
- Enhancement: support all instance types in the i3 family.
- Fix: prevent a problem where in rare situations a node could stop applying transactions.

<a id="outline-container-995-9204"></a>

<a id="995-9204"></a>

## 2023/06/16 - 995-9204

<a id="text-995-9204"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

Datomic cloud AMIs are free of any markup outside the AWS marketplace under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.html). Check the [Datomic Cloud](https://blog.datomic.com/2023/06/datomic-cloud-is-free.html) is Free blog post.

<a id="outline-container-990-9202"></a>

<a id="990-9202"></a>

## 2023/02/28 - 990-9202

<a id="text-990-9202"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Performance: Datomic now uses caffeine instead of guava for the object cache.
- Performance: improved fressian read.
- Feature: io-stats for transactions and queries. See [Io-stats](../../../04-apis/11-io-stats/io-stats.md).
- Feature: query-stats. See [Query-stats](../../../04-apis/12-query-stats/query-stats.md).
- Fix: attribute names that begin with an underscore can be used for forward lookups in entity and pull. Note that naming attributes with a leading underscore is strongly discouraged because it conflicts with the convention for reverse lookup.
- Fix: critical bug preventing transactions in 9188.
- Fix: pull performance regression introduced in 9188.
- Fix: exception when using io-stats in nested contexts, you should no longer see "No implementation of method: :-merge-stats of protocol".
- Upgraded AWS libraries to 1.12.358.

<a id="outline-container-client-1-0-123"></a>

<a id="client-1-0-123"></a>

## 2023/02/28 1.0.123 - Client-Cloud Update

<a id="text-client-1-0-123"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Feature: query-stats for transactions and queries. Check [Query-stats](../../../04-apis/12-query-stats/query-stats.md).

<a id="outline-container-981-9188"></a>

<a id="981-9188"></a>

## 2022/11/29 - 981-9188

<a id="text-981-9188"></a>

> The 981-9188 release templates have been removed (12/12/2022) per [Critical Notice](../../releases.md).
>
> This release introduced a problem in Datomic that could eventually halt transactions (but not Reads). All templates have been removed and de-listed from the docs and marketplace. The 990-9202 release contains all features in this release and replaces 981-9188.
>
> Recommendation: if you upgraded to this specific version is to immediately upgrade again to the latest 990-9202.

<a id="outline-container-ion-62"></a>

<a id="ion-62"></a>

## 2022/11/29 1.0.62 - Ion

<a id="text-ion-62"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

Fix: requiring `dev-local` no longer disables `ion.cast/initialize-redirect`.

<a id="outline-container-client-1-0-122"></a>

<a id="client-1-0-122"></a>

## 2022/11/29 1.0.122 - Client-Cloud Update

<a id="text-client-1-0-122"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Feature: Io-stats for transactions and queries. Check [io-stats](../../../04-apis/11-io-stats/io-stats.md).

<a id="outline-container-973-9132"></a>

<a id="973-9132"></a>

## 2022/06/01 - 973-9132

<a id="text-973-9132"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Upgrade Clojure to 1.11.1.
- Upgrade AWS SDK to 1.12.132.
- Upgrade com.cognitect/s3-creds to 1.0.27.
- Upgrade com.datomic/memcached-asg-java-client to 1.1.0.33.
- Upgrade transit-clj to 1.0.329.
- Upgrade com.datomic/client to 1.0.126.
- Upgrade com.datomic/client-cloud to 1.0.120.
- Upgrade tools.namespace to 1.2.0.
- Upgrade The AMI is now based on the 3/16/2022 version of Linux 2 base AMI.
- Upgrade NodeJS used in Lambdas to 14.x.
- Add new output `IonApiIntegrationId`.
- Upgrade Corretto11 to 11.0.14+10.

<a id="outline-container-ion-59"></a>

<a id="ion-59"></a>

## 2022/04/06 1.0.59 - Ion

<a id="text-ion-59"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

- Upgrade transit-clj to 1.0.329.
- Upgrade aws-java-sdk-ssm to 1.12.132.

<a id="outline-container-ion-dev-1-0-306"></a>

<a id="ion-dev-1-0-306"></a>

## 2022/04/06 1.0.306 - Ion-dev

<a id="text-ion-dev-1-0-306"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Upgrade aws-java-sdk-\* to 1.12.132.
- Upgrade s3-libs to 1.0.46.

<a id="outline-container-client-1-0-120"></a>

<a id="client-1-0-120"></a>

## 2021/04/06 1.0.120 - Client-Cloud Update

<a id="text-client-1-0-120"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Upgrade Client to 1.0.126.
- Upgrade s3-creds to 1.0.27.
- Upgrade aws-java-sdk-s3 to 1.12.132.

<a id="outline-container-ion-dev-1-0-304"></a>

<a id="ion-dev-1-0-304"></a>

## 2022/04/1 1.0.304 - Ion-dev

<a id="text-ion-dev-1-0-304"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

Resolved [an issue](https://clojure.org/news/2022/04/01/deref#_from_the_core) where a user may encounter the error:

``` sh
"WARNING: abs already refers to: #'clojure.core/abs in namespace: cognitect.s3-libs.file, being replaced by: #'cognitect.s3-libs.file/abs"
```

<a id="outline-container-939-9127"></a>

<a id="939-9127"></a>

## 2022/01/14 939-9127 - Compute Update

<a id="text-939-9127"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Upgraded AWS Java SDK to 1.12.100.
- Upgraded Jetty to 9.4.41.v20210927.
- Upgraded core.async to 1.5.6348.
- Upgraded core.cache to 1.0.225.
- Upgraded core.memoize to 1.0.253.
- Upgraded data.priority-map to 1.1.0.
- Upgraded tools.analyzer to 1.1.0.
- Upgraded tools.analyzer.jvm to 1.2.2.
- Upgraded tools.namespace to 1.1.1.
- Upgraded tools.reader to 1.3.6.
- Upgraded asm to 9.2.
- Upgraded org.slf4j to 1.7.32.
- Upgraded http-client to 1.0.111.
- Upgraded Guava to 31.0.1.
- Upgraded commons-codec to 1.15.
- Upgraded Java 11 to 11.0.13+8.
- Upgrade: The AMI is now based on the 12/01/2021 version of Linux 2 base AMI.

<a id="outline-container-client-1-0-119"></a>

<a id="client-1-0-119"></a>

## 2022/01/14 1.0.119 - Client-Cloud Update

<a id="text-client-1-0-119"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Upgraded AWS Java SDK to 1.12.100.
- Upgraded Jetty to 9.4.44.v20210927.
- Upgraded core.async to 1.5.648.
- Upgraded core.cache to 1.0.225.
- Upgraded data.priority-map to 1.1.0.
- Upgraded http-client to 1.0.110.

<a id="outline-container-ion-dev-1-0-298"></a>

<a id="ion-dev-1-0-298"></a>

## 2022/01/14 1.0.298 - Ion-dev

<a id="text-ion-dev-1-0-298"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Upgraded AWS Java SDK to 1.12.100

<a id="outline-container-ion-58"></a>

<a id="ion-58"></a>

## 2022/01/14 1.0.58 - Ion

<a id="text-ion-58"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

Upgraded AWS Java SDK to 1.12.100.

<a id="outline-container-cli-1.0.91"></a>

<a id="cli-1.0.91"></a>

## 2022/01/14 1.0.91 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md)

<a id="text-cli-1.0.91"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [1.0.91](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-1.0.91.zip) |

Enhance error message when using `:local/root`.

<a id="outline-container-936-9118"></a>

<a id="936-9118"></a>

## 2021/09/29 936-9118 - Compute and Storage Update

<a id="text-936-9118"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Fix: ensure that code bucket IAM policy points to the correct bucket if the bucket was deleted and recreated.
- Fix: prevent a problem where in rare situations indexing jobs can fail repeatedly with an `ArityException`.
- Enhancement: improve handling of throttling errors during CloudFormation stack creation.
- Enhancement: the datalog engine will now do self-unification within a single clause.
- Upgraded AWS Java SDK to 1.12.1.
- Upgraded Clojure to 1.10.3.
- Upgraded jackson-core to 2.12.3.
- Upgraded Jetty to 9.4.41.v20210516.
- Upgraded core.async to 1.3.618.
- Upgraded http-client to 1.0.108.
- Upgraded transit-clj to 1.0.324.
- Upgraded data.json to 2.4.0.
- Upgraded tools.namespace to 1.1.0
- Upgrade: The AMI is now based on the 07/01/2021 version of Linux 2 base AMI.

<a id="outline-container-client-1-0-117"></a>

<a id="client-1-0-117"></a>

## 2021/09/29 1.0.117 - Client-Cloud Update

<a id="text-client-1-0-117"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Upgraded AWS Java SDK to 1.12.1.
- Upgraded Jetty to 9.4.41.v20210516.
- Upgraded core.async to 1.3.618.
- Upgraded core.cache to 1.0.207.
- Upgraded http-client to 1.0.108.
- Upgraded transit-clj to 1.0.324.

<a id="outline-container-ion-dev-294"></a>

<a id="ion-dev-294"></a>

## 2021/09/29 1.0.294 - Ion-dev

<a id="text-ion-dev-294"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Upgraded Lambda runtime to Corretto, per [AWS policy](https://aws.amazon.com/blogs/compute/announcing-migration-of-the-java-8-runtime-in-aws-lambda-to-amazon-corretto/).
- Upgraded AWS Java SDK to 1.12.1.
- Upgraded data.json to 2.4.0.

<a id="outline-container-ion-57"></a>

<a id="ion-57"></a>

## 2021/09/29 1.0.57 - Ion

<a id="text-ion-57"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) |
|---------------------------------------------------------------|
| ` `                                                           |

- Fix: `Nil` error thrown when calling cast before calling `initialize-redirect`.
- Upgraded AWS Java SDK to 1.12.1.
- Upgraded transit-clj to 1.0.324.
- Upgraded data.json to 2.4.0.

<a id="outline-container-884-9095"></a>

<a id="884-9095"></a>

## 2021/07/13 884-9095 - Compute Update

<a id="text-884-9095"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Primary Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|
|  |  |  |

- Enhancement: many new [EC2 instance sizes](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md#instance-sizes).
- Enhancement: [lower pricing](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md#hourly-price) for all instance sizes.
- Enhancement: [API Gateways](../../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md#api-gateway) for client and application internet access.
- Enhancement: [run analytics anywhere](../../../08-analytics/03-cloud-configuration/cloud-configuration.md).
- Upgrade: compute nodes have been upgraded from Java 8 to Java 11.
- Replaced: the client access gateway is no longer available; you can connect directly to the new client API gateway.
- Replaced: the analytics gateway is no longer available; you can run your own analytics node or cluster.
- Replaced: the solo tier is no longer available; the production compute stack now scales all the way down to t3.small.
- Replaced: the socks proxy is no longer available; clients can connect directly to the client API Gateway.
- Replaced: each compute group now uses an ALB instead of an NLB.

This upgrade will cause up to one minute of downtime for each compute group. Make sure to perform this upgrade at a time that minimizes the impact of these disruptions.

In addition, make sure to read the upgrade instructions below *for each of the following scenarios that apply to your system today*: solo systems, production systems, developer connections, application connections, analytics connections, and web application (ion) connections.

<a id="outline-container-884-solo"></a>

<a id="884-solo"></a>

### 884-9095 for Solo Users

<a id="text-884-solo"></a>

Datomic no longer has a Solo compute stack. If you were using Solo you can upgrade to Production at no additional cost by performing the following steps:

- Your web applications no longer need to go through a [web lambda proxy](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#web-lambda-proxies). They can (and must) instead use [HTTP direct](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#web-ion). HTTP direct is higher performance and simplifies your code, which no longer needs to call `ionize`.
- Perform a [storage upgrade](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade).
- Perform a [compute upgrade](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade), selecting the t3.small instance size (the default).

<a id="outline-container-884-prod"></a>

<a id="884-prod"></a>

### 884-9095 for Production Users

<a id="text-884-prod"></a>

If you are running Production, you now have a set of t3 instance sizes to choose from. Many users will be able to provision smaller, less expensive instances:

- Unless your compute group [needs valcache](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md#valcache), you should switch from your current i3 instance to the matching-sized t3 instance.
- If you believe you were already overprovisioned with i3.large, you should consider a [smaller t3 instance size](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md#instance-sizes).

<a id="outline-container-884-developer"></a>

<a id="884-developer"></a>

### 884-9095 for Developer Connections

<a id="text-884-developer"></a>

884-9095 significantly simplifies developer connections. If you connect to Datomic with a socks proxy to the access gateway, remove all of those steps from your workflow. Instead:

- When you upgrade a compute group, enable the client API gateway.
- Configure your clients to connect directly to the client API gateway endpoint.

<a id="outline-container-884-application-connections"></a>

<a id="884-application-connections"></a>

### 884-9095 for Application Connections

<a id="text-884-application-connections"></a>

884-9095 significantly simplifies application connections. If your application connections require managing security groups, VPC endpoints, or VPC peering, remove all of these steps from your workflow. Instead:

- When upgrading a compute group, enable the client API gateway.
- Configure your application clients to connect directly to the client API gateway endpoint.

<a id="outline-container-884-ion-applications-api-gateway"></a>

<a id="884-ion-applications-api-gateway"></a>

### 884-9095 for Ion Applications with API Gateway

<a id="text-884-ion-applications-api-gateway"></a>

If you manually created an API Gateway for your ion application on a previous release of Datomic, that gateway will no longer work. You should note any custom configuration for reference and then delete the gateway. Then, let Datomic create the API Gateway for you (preferred), or follow the updated instructions for creating your own API Gateway.

<a id="outline-container-884-ion-applications-lambda-proxy"></a>

<a id="884-ion-applications-lambda-proxy"></a>

### 884-9095 for Ion Applications using Web Lambda Proxies

<a id="text-884-ion-applications-lambda-proxy"></a>

If you were using [Web Lambda Proxies](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#web-lambda-proxies), then you should change to HTTP Direct or lambdas. Perform the following:

- Move the function to the `:http-direct` or `:lambdas` key in your ion-config.edn.
- The [`ionize`](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#ionize) function should not be used.
- Expect the appropriate input data for the type of entry point ([HTTP Direct](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#web-ion) or [lambda](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#lambda-ion)).

<a id="outline-container-884-analytics"></a>

<a id="884-analytics"></a>

### 884-9095 for Analytics Users

<a id="text-884-analytics"></a>

If you were using Datomic analytics via the access gateway, you will now need to start your own analytics cluster. [Configure analytics](../../../08-analytics/03-cloud-configuration/cloud-configuration.md) on any machine or cluster of machines (locally or in EC2), and connect to the client API gateway endpoint.

<a id="outline-container-884-storage"></a>

<a id="884-storage"></a>

## 2021/07/13 884-9095 - Storage Update

<a id="text-884-storage"></a>

Enhancement: The storage template now sets DDB provisioning to fit within the AWS free tier if your usage is low enough.

<a id="outline-container-cli-0-10-89"></a>

<a id="cli-0-10-89"></a>

## 2021/07/13 - 0.10.89 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md)

<a id="text-cli-0-10-89"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.10.98](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.10.98.zip) |

Add describe-groups system command

<a id="outline-container-client-0-8-113"></a>

<a id="client-0-8-113"></a>

## 2021/07/13 0.8.113 - Client-Cloud Update

<a id="text-client-0-8-113"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Add support for hmac through API Gateway

<a id="outline-container-ion-dev-290"></a>

<a id="ion-dev-290"></a>

## 2021/07/13 0.9.290 - Ion-dev

<a id="text-ion-dev-290"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Update dep list for Datomic Cloud 884-9095
- Enhancement: improved integration between ions and AWS Application Load Balancers for the cloud version release.

<a id="outline-container-781-9041"></a>

<a id="781-9041"></a>

## 2021/03/02 - 781-9041 - Compute Update

<a id="text-781-9041"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- Upgrade: AWS Lambda Runtimes moved to NodeJs 12.x.
- Enhancement: new AWS Region - `ca-central-1`.
- Upgrade Jetty server to version 9.4.36.v20210114.

<a id="outline-container-ion-dev-282"></a>

<a id="ion-dev-282"></a>

## 2021/02/23 0.9.282 - Ion-dev && 0.9.50 - Ion

<a id="text-ion-dev-282"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- Ion-dev
  - Improvement: limit how long to wait for a cluster node to gracefully shut down.
  - Improvement: increase performance of Ion request handler.
  - Fix: suppress noisy AsyncContext Alert caused by Ion timeout.
- Ion
  - Improvement: `get-params` now allows arbitrary number of parameters.

<a id="outline-container-772-9034"></a>

<a id="772-9034"></a>

## 2021/02/23 - 772-9034 - Compute Update

<a id="text-772-9034"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- Fix: [attribute predicates](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#attribute-predicates) are now applied to assertions only.
- Upgrade to presto 348 for [Datomic analytics](../../../08-analytics/04-sql-cli/sql-cli.md).

<a id="outline-container-client-0-8-105"></a>

<a id="client-0-8-105"></a>

## 2021/01/20 - 0.8.105 - Client-Cloud Update

<a id="text-client-0-8-105"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Improvement: make client dynaload thread-safe.

<a id="outline-container-732-8992"></a>

<a id="732-8992"></a>

## 2020/11/30 732-8992 - Compute Update

<a id="text-732-8992"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New: change the scale of a [BigDecimal attribute](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#notes-on-value-types) in a transaction.
- Upgrade to presto 346, fixing a [bug](https://github.com/prestosql/presto/commit/e7eeeedcc9751c022ffb9df648ee5442cd421c32) that prevents analytics gateway from launching.
- Fix: reenable query counts metric in [dashboard](../../../05-operation/01-pro/06-monitoring-and-performance/monitoring-and-performance.md).
- Fix: query correctly treats range functions as functions (not as predicates).
- New region: `eu-north-1`.

<a id="outline-container-715-8973"></a>

<a id="715-8973"></a>

## 2020/09/23 715-8973 - Compute Update

<a id="text-715-8973"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New region: `ap-south-1`.
- Fix: improve storage garbage collection.
- Fix: prevent situation where `tx-range` sometimes returned one extra transaction prior to a specified instant.

<a id="outline-container-704-8957"></a>

<a id="704-8957"></a>

## 2020/08/07 704-8957 - Compute Update

<a id="text-704-8957"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature: [cancel](../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md).
- New region: `eu-west-2`.
- Fix: prevent race conditions in Valcache that could lead to a failed read.
- Improvement: better entity predicate error messages.
- Improvement: better indexing performance.
- Upgrade: the version of the Presto server running on the access gateway is now 338. This includes an upgrade to Java 11 on the access gateway.
- Upgrade: the AMI is now based on the 6/17/2020 version of Linux 2 base AMI.
- Upgrade: AWS SDK for Java to version 1.11.826.
- Upgrade: core.async to version 1.3.610.

<a id="outline-container-ion-dev-276"></a>

<a id="ion-dev-276"></a>

## 2020/08/07 0.9.276 - Ion-Dev && 0.9.48 - ion

<a id="text-ion-dev-276"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- New feature: [cancel](../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md).
- Cloud-deps update.

<a id="outline-container-client-08-102"></a>

<a id="client-08-102"></a>

## 2020/07/21 - 0.8.102 - Client-Cloud Update

<a id="text-client-08-102"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Fix: `datomic.api.client.async/client` now accepts `:dev-local` as a `:server-type`.

<a id="outline-container-client-08-101"></a>

<a id="client-08-101"></a>

## 2020/07/17 - 0.8.101 - Client-Cloud Update

<a id="text-client-08-101"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

New feature: [dev-local](../../../01-setup/03-local-setup/local-setup.md).

<a id="outline-container-668-8927"></a>

<a id="668-8927"></a>

## 2020/05/14 - 668-8927 - Compute Update

<a id="text-668-8927"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature: [qseq](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md#qseq)
- New feature: [index-pull](../../../04-apis/06-index-pull/index-pull.md)
- New feature: [xform](../../../06-reference/03-query-and-pull/03-pull/pull.md#xform-option)
- Enhancement: improve index efficiency.
- Enhancement: improve performance of pull in queries.
- Enhancement: improve internal record keeping of active databases that could lead to spurious error messages.
- Enhancement: base AMI is now sourced from Amazon Linux 2, and includes recent security updates.

> **Upgrade:** As recommended by AWS, we have upgraded our base AMI to [Amazon Linux 2](https://aws.amazon.com/blogs/aws/update-on-amazon-linux-ami-end-of-life/). This new AMI includes a breaking change to the Linux Netcat utility that Ions use to deploy new code to a cluster. We encourage all users of Ions to upgrade to [version 0.9.265](#ion-dev-265) or later of ion-dev prior to upgrading to this release.

<a id="outline-container-ion-dev-265"></a>

<a id="ion-dev-265"></a>

## 2020/05/14 - 0.9.265 - Ion-Dev && 0.9.43 - Ion

<a id="text-ion-dev-265"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- Enhancement: calculate transitive list of dependencies in [`:dependency-conflict` map](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#dependency-conflicts).
- Update dep list for [Cloud 668-8927](#668-8927) release.

<a id="outline-container-client-08-96"></a>

<a id="client-08-96"></a>

## 2020/05/14 - 0.8.96 - Client-Cloud Update

<a id="text-client-08-96"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- New feature: [qseq](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md#qseq).
- New feature: [index-pull](../../../04-apis/06-index-pull/index-pull.md).
- Updated jetty dependencies from 9.4.24.v20191120 to 9.4.27.v20200227.

<a id="outline-container-cli-0-10-82"></a>

<a id="cli-0-10-82"></a>

## 2020/04/28 - 0.10.82 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md)

<a id="text-cli-0-10-82"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.10.82](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.10.82.zip) |

Enhancement: add `--ssho` option to the [gateway restart command](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md#restart) to pass ssh configuration options as if using `ssh -o <option>`

<a id="outline-container-616-8879"></a>

<a id="616-8879"></a>

## 2020/02/21 - 616-8879 - Compute Update

<a id="text-616-8879"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature: `[:db/retract eid aid]` will retract all values for an eid/aid combination.
- Critical fix: regression introduced in 569-8835 where `datoms`, `seek-datoms`, and `index-range` return incorrect results if `Iterable.iterator` is called more than once on the returned value.
- Fix: respect `nil` as a limit in query `pull` expression.
- Fix: respect `false` as a default in query `pull` expressions for boolean-valued attributes.
- Fix: allow arbitrary `java.util.List` (not just Clojure vectors) for lookup refs.

<a id="outline-container-cli-0-10-81"></a>

<a id="cli-0-10-81"></a>

## 2020/02/19 - 0.10.81 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md)

<a id="text-cli-0-10-81"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.10.81](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.10.81.zip) |

Many new features - [see docs](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md).

<a id="outline-container-ion-dev-251"></a>

<a id="ion-dev-251"></a>

## 2020/02/03 - 0.9.251 - Ion-dev

<a id="text-ion-dev-251"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

Increase timeout for how long a deployment will wait for dependencies to sync on an instance.

<a id="outline-container-589-8846"></a>

<a id="589-8846"></a>

## 2020/01/20 - 589-8846 - Storage and Compute Update

<a id="text-589-8846"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New region: `sa-east-1`.
- Better tagging of resources created by Datomic.
- Fixed problem using with-db from ions.

<a id="outline-container-cli-0-9-33"></a>

<a id="cli-0-9-33"></a>

## 2019/11/26 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) - 0.9.33

<a id="text-cli-0-9-33"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.9.33](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.9.33.zip) |

> This release requires a version of Datomic Cloud 569-8835 or newer.

- Enhancement: `datomic-gateway restart` now just restarts the process running on the access gateway, instead of restarting the whole instance. This results in faster restart times when making configuration changes. Restarting a bastion-only access gateway has no effect.
- Enhancement: automatically retrieve the host key from the access gateway. There will no longer be a warning about the authenticity of the host.

<a id="outline-container-569-8835"></a>

<a id="569-8835"></a>

## 2019/11/26 - 569-8835 - Storage and Compute Update

<a id="text-569-8835"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- Fix: resolve tempids for reference attributes inside tuples.
- Enhancement: performance improvement for range predicates in analytics support.
- Enhancement: SSH public keys automatically handled by access gateway and proxy script.
- Enhancement: AutoScalingGroup details exposed as CloudFormation outputs.
- Enhancement: [JDBC metadata](../../../08-analytics/03-cloud-configuration/cloud-configuration.md#jdbc-metadata) support in analytics.
- Upgrade: AWS Lambda Runtimes moved to NodeJs 10.x.

<a id="outline-container-ion-dev-247"></a>

<a id="ion-dev-247"></a>

## 2019/11/19 - 0.9.247 - Ion-dev

<a id="text-ion-dev-247"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

- Better error message for invalid ion-config.edn.
- Update commands to match the preferred approach of [installing ion-dev in your user deps.edn](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev).
- Use slf4j-simple to prevent console warnings when invoking tools.

<a id="outline-container-client-08-81"></a>

<a id="client-08-81"></a>

## 2019/11/14 - 0.8.81 - Client-Cloud Update

<a id="text-client-08-81"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

Documentation string updates

<a id="outline-container-ion-dev-240"></a>

<a id="ion-dev-240"></a>

## 2019/11/12 - 0.9.240 - Ion-dev

<a id="text-ion-dev-240"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

Upgrade Clojure tools.deps.alpha to 0.8.584.

<a id="outline-container-cli-0-9-21"></a>

<a id="cli-0-9-21"></a>

## 2019/11/06 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) - 0.9.21

<a id="text-cli-0-9-21"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.9.21](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.9.21.zip) |

- Enhancement: added `--ssho` to allow any SSH -o option to be passed, removed `--no-host-key-checking` option.
- `--instance-wait` option renamed to `--wait`.

<a id="outline-container-535-8812"></a>

<a id="535-8812"></a>

## 2019/10/01 - 535-8812 - Compute Template Update

<a id="text-535-8812"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- Fix: prevent exception thrown when handling COUNT(\*) clauses in analytics support.
- Fix: do not create redundant `:db.install/attribute` datoms for idempotent schema operations.
- Update transactor Clojure dependency to 1.10.1.
- Enhancement: new AWS Region - ap-northeast-1.

<a id="outline-container-cli-0-9-11"></a>

<a id="cli-0-9-11"></a>

## 2019/10/01 - [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) - 0.9.11

<a id="text-cli-0-9-11"></a>

| [CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md) |
|----|
| [0.9.11](https://datomic-releases-1fc2183a.s3.amazonaws.com/tools/datomic-cli/datomic-cli-0.9.11.zip) |

Initial release of [CLI tools](../../../05-operation/02-cloud/11-how-to/how-to.md)

<a id="outline-container-512-8806"></a>

<a id="512-8806"></a>

## 2019/10/01 - 512-8806 - Storage and Compute Template Update

<a id="text-512-8806"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature preview: analytics. Check [Analytics Concepts](../../../08-analytics/01-analytics-concepts/analytics-concepts.md).
- Fix: allow Datomic Cloud to launch correctly in accounts that have a large number of existing ASGs.

<a id="outline-container-ion-dev-234"></a>

<a id="ion-dev-234"></a>

## 2019/08/15 - 0.9.234 - Ion-dev & 0.9.35 - Ion

<a id="text-ion-dev-234"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

Enhancement: allow for the inclusion of the target dir in the `:paths` list.

<a id="outline-container-482-8794"></a>

<a id="482-8794"></a>

## 2019/08/06 - 482-8794 - Compute Template Update

<a id="text-482-8794"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New: upgrade from t2 to t3 instances for bastion and query groups.
- Fix: `tx-range` now returns a map with a `:data` key, consistent with the docs.
- Fix: correctly handle boolean attributes in composite tuples.
- Fix: prevent erroneous attempts to use Datomic On-Prem's excision feature.

<a id="outline-container-480-8772"></a>

<a id="480-8772"></a>

## 2019/07/09 - 480-8772 - Compute Template Update

<a id="text-480-8772"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

Fixed problem where databases that change an attribute from `:db.cardinality/one` to~:db.cardinality/many~ may become unavailable after a process restart.

<a id="outline-container-480-8770"></a>

<a id="480-8770"></a>

## 2019/06/27 - 480-8770 - Compute Template Update

<a id="text-480-8770"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature: [tuples](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#tuples).
- New feature: [attribute predicates](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#attribute-predicates).
- New feature: [entity specs](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#entity-specs).
- New feature: [return maps](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#return-maps).
- Fix: `sample` aggregate could hang the query thread.

<a id="outline-container-client-08-78"></a>

<a id="client-08-78"></a>

## 2019/06/18 - 0.8.78 - Client-Cloud Update

<a id="text-client-08-78"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- New feature: [return maps](../../../06-reference/03-query-and-pull/02-query-reference/query-reference.md#return-maps).
- New feature: reverse references in `nav` (try it in [REBL](http://rebl.cognitect.com/download.html)).

<a id="outline-container-ion-dev-231"></a>

<a id="ion-dev-231"></a>

## 2019/06/04 - Ion-dev 0.9.231

<a id="text-ion-dev-231"></a>

| [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|-----------------------------------------------------------------------|
| ` `                                                                   |

Improvement: fixed issue where some older Java libraries could not be loaded in an ion application

<a id="outline-container-477-8741"></a>

<a id="477-8741"></a>

## 2019/05/16 - 477-8741 - Compute Template Update - [HTTP Direct](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#http-direct-config)

<a id="text-477-8741"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

The 477-8741 release contains fixes, enhancements, and dependency updates:

- Enhancement: [HTTP Direct](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#http-direct-config) integration for ions.
- Enhancement: improved integration between ions and AWS Network Load Balancers. This eliminates transient errors during rolling deployments.
- Enhancement: improved integration between ions and AWS Lambda. This also eliminates transient errors.
- Fix: issue where cluster nodes could become unresponsive when serving multiple databases or a burst of `tx-range` queries.
- Fix: nested queries could deadlock the query pool on Solo nodes.
- Fix: increased direct memory on Production nodes to prevent out-of-direct-memory errors.
- Update: version 1.7.26 of org.slf4j libraries.

<a id="outline-container-ion-dev-229"></a>

<a id="ion-dev-229"></a>

## 2019/05/15 - 0.9.229 - Ion-Dev & 0.9.34 - Ion

<a id="text-ion-dev-229"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- New feature: HTTP Direct.
- Enhancement: improved integration between ions and AWS NLBs.

<a id="outline-container-470-8654.1"></a>

<a id="470-8654.1"></a>

## 2019/04/25 - 470-8654.1 - Compute, Storage, and [Query Group](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) Update

<a id="text-470-8654.1"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

> Our Cloud Formation templates use node.js lambdas to create support functions for Cloud Formation. April 30th 2019 is the end-of-life date for AWS Lambda node.js runtime that we currently use.
>
> Effective May 1, 2019, Datomic Cloud CloudFormation templates older than 4/25/2019 will no longer be executed. Datomic systems launched with those templates will continue to run, but any template operations (launching or upgrading CloudFormation stacks) will fail.
>
> All Datomic Cloud users should [upgrade](../../../05-operation/02-cloud/14-upgrading/upgrading.md) to [470-8654.1](#470-8654.1) at their earliest convenience.
>
> For more information see the AWS [runtime support policy](https://docs.aws.amazon.com/lambda/latest/dg/runtime-support-policy.html).

Critical: Updated to Node.js 8.10 runtime. All Datomic Cloud users should [upgrade](../../../05-operation/02-cloud/14-upgrading/upgrading.md) at their earliest convenience.

<a id="outline-container-470-8654"></a>

<a id="470-8654"></a>

## 2019/02/22 - 470-8654 - Compute Template Update

<a id="text-470-8654"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

> If you have created a VPC Endpoint using the provided CloudFormation Template, you will need to delete that CloudFormation Stack before upgrading to this version of Datomic Cloud.
>
> Attempting to upgrade to or past this release without deleting the Stack will result in a failed update with the message: `Export <SystemName>-VpcEndpointServiceName cannot be deleted as it is in use by <SystemName>-vpc-endpoint`
>
> See the troubleshooting documentation for more information.

The 470-8654 release contains fixes, enhancements, and dependency updates:

- Fix: production nodes now use the [documented -Xss values](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#jvm-settings) for starting the JVM, preventing stack overflow when compiling complex ion applications.
- Fix: fixed bug where ion connections could fail to become aware of recent transactions in a timely manner.
- Fix: allow bigint values in transaction data.
- Fix: corrected allowlist handling of function calls from datalog rules.
- Enhancement: new AWS Region - ap-southeast-1.
- Enhancement: improved Valcache cleanup algorithm.
- Enhancement: reduce storage overhead of transactions.
- Enhancement: defer the creation of VPC Endpoint Service until specifically needed for [cross-VPC client access](../../../05-operation/02-cloud/09-vpc-access/vpc-access.md).
- Update to version 2.9.8 of [Jackson](https://github.com/FasterXML/jackson).
- Update to version 1.11.479 of the [AWS SDK for Java](https://aws.amazon.com/sdk-for-java/).

<a id="outline-container-454-8573"></a>

<a id="454-8573"></a>

## 2018/12/10 - 454-8573 - Compute Template Update

<a id="text-454-8573"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

The 454-8573 release contains performance and availability enhancements:

- Enhancement: you can configure systems to [preload a database](../../../03-tutorials/03-cloud-getting-started/cloud-getting-started.md) before serving requests, eliminating a source of [unavailable anomalies](https://github.com/cognitect-labs/anomalies#the-categories).
- Enhancement: ion deployments [load active databases before serving requests](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#deploy), eliminating a source of [unavailable anomalies](https://github.com/cognitect-labs/anomalies#the-categories).
- Enhancement: improved throughput for transactions initiated by ion applications running the Production Topology.
- Enhancement: improved performance for systems that create and delete many databases (e.g. test systems).
- Enhancement: improvements to logging.

<a id="outline-container-ion-dev-186"></a>

<a id="ion-dev-186"></a>

## 2018/12/10 - 0.9.186 - Ion-Dev & 0.9.28 - Ion

<a id="text-ion-dev-186"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- Enhancement: increase CodeDeploy timeout to 5 minutes.
- Enhancement: include doc strings for user-facing functions in the build artifact.

<a id="outline-container-client-0-8-71"></a>

<a id="client-0-8-71"></a>

## 2018/11/28 - 0.8.71 - Client-Cloud Update

<a id="text-client-0-8-71"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Add compatibility with com.cognitect/aws-api.
- Add Datafy.
- Upgraded http-client to 0.1.87.
- Improved error reporting.

<a id="outline-container-441-8505"></a>

<a id="441-8505"></a>

## 2018/10/10 - 441-8505 - Critical Update - Compute Template Update

<a id="text-441-8505"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

Release 441-8505 includes critical updates. All users of the Production Topology and Query Groups should upgrade to 441-8505 immediately. The Solo Topology is not affected.

Critical: fixes a problem that can cause portions of the log to become inaccessible. Please update as soon as possible.

<a id="outline-container-441-8477"></a>

<a id="441-8477"></a>

## 2018/09/07 - 441-8477 - Compute Template Update

<a id="text-441-8477"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Query Groups](../../../05-operation/02-cloud/05-compute-templates/compute-templates.md) |
|----|----|----|----|
|  |  |  |  |

- New feature: [query groups](../../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md#query-groups).
- New instance type option: i3.xlarge for [Production](../../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md).
- Improved memory settings: more stack space for [Solo](../../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md), more heap space for Production.
- Bugfix: fixed bug that could prevent a Production node from beginning indexing jobs.

<a id="outline-container-client-0-8-63"></a>

<a id="client-0-8-63"></a>

## 2018/08/21 - 0.8.63 - Client-Cloud Update

<a id="text-client-0-8-63"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Bugfix: fixed bug that could cause a `with` database query to go to the wrong node in a production cluster.
- Bugfix: fixed Jetty configuration that could cause a client to prevent JVM from shutting down.
- Upgraded transit-clj to 0.8.313.
- `:query-group` parameter is no longer required in the client arg-map.

<a id="outline-container-ion-dev-176"></a>

<a id="ion-dev-176"></a>

## 2018/08/15 - 0.9.176 - Ion-Dev && 0.9.26 - Ion

<a id="text-ion-dev-176"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

Enhancement: [parameters](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#parameters) library for working with the [AWS systems manager parameter store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-paramstore.html).

<a id="outline-container-409-8407"></a>

<a id="409-8407"></a>

## 2018/08/15 - 409-8407 - Compute Template Update

<a id="text-409-8407"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) |
|----|----|----|
|  |  |  |

- Bugfix: allow retraction of `:db/unique` attributes.
- Bugfix: coerce `Integer` values to long when needed in transactions.
- Enhancement: better memory utilization allows larger query results.
- Enhancement: automatically rollback deployments when an ion application fails to load.
- Added support for `ap-southeast-2` (Sydney) region.

<a id="outline-container-ion-dev-173"></a>

<a id="ion-dev-173"></a>

## 2018/07/10 - 0.9.173 - Ion-dev & 0.9.14 - Ion

<a id="text-ion-dev-173"></a>

| [Ion](../../../05-operation/02-cloud/11-how-to/how-to.md#ion) | [Ion dev](../../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) |
|----|----|
| ` ` | ` ` |

- New Feature: `Datomic.ion.cast` library for [monitoring ions](../../../07-datomic-cloud-ions/10-monitoring-ions/monitoring-ions.md).
- Bugfix: fixed race condition in ion code loading that could allow ion invocation before namespace completely loaded.
- Enhancement: [warn on dependency conflicts](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#dependency-conflicts).
- Improvement: prefer shell-friendly symbols instead of strings as arguments to datomic.ion.dev CLI commands.
- Improvement: better error messaging when [deploying](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#deploy) to the wrong region.
- Improvement: list available deploy groups in [push output](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#push).
- Improvement: enforce the requirement for `:uname` when project has a `:local/root` in deps.edn.

<a id="outline-container-client-0-8-56"></a>

<a id="client-0-8-56"></a>

## 2018/07/02 - 0.8.56 - Client Cloud Update

<a id="text-client-0-8-56"></a>

- Enhancement: added sync to client API. Check [Client Synchronization](../../../06-reference/02-transactions/06-client-synchronization/client-synchronization.md).
- Better error message when unable to connect to cluster or proxy.

<a id="outline-container-402-8396"></a>

<a id="402-8396"></a>

## 2018/06/29 - 402-8396 - Compute Template Update

<a id="text-402-8396"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) |
|----|----|----|
|  |  |  |

- Upgraded AWS libs to 1.11.349.
- Upgraded Jackson libs to 2.9.5.
- Fixed cache problem where all `d/with` databases deriving from a common initial call to `d/with-db` had the same common value.

<a id="outline-container-0-8-54"></a>

<a id="0-8-54"></a>

## 2018/06/06 - 0.8.54 - Client-Cloud Update

<a id="text-0-8-54"></a>

| [client-cloud](../../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md#installing) |
|----|
| ` ` |

- Enhancement: added [:server-type :ion](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#server-type-ion).
- Enhancement: ensure recentness of `d/db conn`.

<a id="outline-container-397-8384"></a>

<a id="397-8384"></a>

## 2018/06/06 - 397-8384 - Storage and Compute Template Update

<a id="text-397-8384"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) |
|----|----|----|
|  |  |  |

- Enhancement: [Datomic Ions](../../../07-datomic-cloud-ions/01-ions-overview/ions-overview.md).
- Improvement: Replaced Application Load Balancer with Network Load Balancer. If your applications run in a separate VPC you will need to [configure a VPC endpoint](../../../05-operation/02-cloud/09-vpc-access/vpc-access.md).

<a id="outline-container-303-8300"></a>

<a id="303-8300"></a>

## 2018/02/21 - 303-8300 - Storage and Compute Template Update

<a id="text-303-8300"></a>

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) |
|----|----|----|
|  |  |  |

- Bugfix: doubles and floats allowed in transactions.
- Bugfix: avoid unnecessary ":AdopterSkippedOlder" alert when creating a new database.
- Update: latest Amazon Linux patches.
- Improvement: better error handling in the storage template.
- Improvement: reduce memcached timeout.

<a id="outline-container-297-8291"></a>

<a id="297-8291"></a>

## 2018/01/15 - 297-8291

<a id="text-297-8291"></a>

Initial release.

| [Storage](../../../05-operation/02-cloud/14-upgrading/upgrading.md#storage-only-upgrade) | [Solo Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) | [Production Compute](../../../05-operation/02-cloud/14-upgrading/upgrading.md#compute-only-upgrade) |
|----|----|----|
|  |  |  |
