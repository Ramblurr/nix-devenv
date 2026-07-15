<a id="content"></a>

<a id="legacy-storage-services"></a>

# Legacy Storage Services

The storage services on this page are supported only for Enterprise customers. If you are setting up Datomic, use one of [these storage services](../../../05-operation/01-pro/01-storage-services/storage-services.md) instead.

<a id="outline-container-provisioning-riak"></a>

<a id="provisioning-riak"></a>

## Provisioning Riak

<a id="text-provisioning-riak"></a>

Riak is supported only on Datomic versions up to 1.0.6242, inclusive.

Using Riak as a storage requires both a Riak cluster and a ZooKeeper cluster. If you already have either of these running, you can use the ones you have. Each Datomic system needs its own bucket in the Riak cluster. Datomic uses unique paths for its ZooKeeper nodes (starting with /datomic), so will not clash with other keys.

To setup ZooKeeper, follow the [directions](https://zookeeper.apache.org/doc/r3.4.11/zookeeperStarted.html) on the ZooKeeper site. These notes are just a checklist to help you make sure you covered everything.

- get zookeeper from the [zookeeper site](https://zookeeper.apache.org/releases.html)

- edit config files, give instances running on same box (e.g. for dev) different ports

- each instance needs a cfg file with section referencing all cluster members like this:

  server.1=127.0.0.1:2888:3888 server.2=127.0.0.1:2889:3889 server.3=127.0.0.1:2890:3890

- autopurge is ok

- put a 'myid' file (containing e.g. 1, 2 or 3) in zk data dir of each instance

- start each instance (e.g. bin/zkServer.sh start conf/zooNNN.cfg)

To setup Riak, follow the [directions](https://docs.riak.com/riak/latest/tutorials/fast-track/) on the Basho site.

After starting the Riak cluster, you need to choose a bucket name for your Datomic system, and add an entry to that bucket named config\zookeeper (note backslash) that describes your zookeeper cluster (as a string of host:port,host:port,…):

- curl -v -d "127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183" -H "Content-Type: text/plain; charset=utf-8" `http://127.0.0.1:8098/riak/bucketname/config\\zookeeper?dw=2`
- simply adding this entry will create the bucket - that's ok, we like the defaults (e.g. N=3)

Next, setup your transactor properties file:

- Copy the *config/samples/riak-transactor-template.properties* file to another location and give it a new name, for instance, *riak-transactor.properties*
- set the entries for riak-host and riak-bucket. You might want to set riak-host to point to a load balancer in order to distribute the workload on the cluster.
- if you are running in Riak's single-box reldev mode, you will need to set the riak-port (since that mode does not use the standard ports, e.g. it will use port 8081/2/3/4 for protocol buffers). Otherwise, do not set it and Datomic will use the default port for the interface you choose.
- Datomic will use the protocol buffers interface for communication with Riak by default. You can set the riak-interface entry to select http, https or protobuf explicitly. Only select https if you already have riak configured with appropriate certificates and can connect to it with a riak or HTTP client, e.g., curl. See the [Riak docs](https://docs.riak.com/riak/latest/ops/advanced/riak-control/) for more information.

Add dependencies for [Riak Client](https://docs.riak.com/riak/latest/dev/using/libraries/) and [Apache Curator Framework](https://curator.apache.org/).

In a maven based build, add the following snippet to the dependencies section of your pom.xml:

``` xml
<dependency>
  <groupId>com.riak.riak</groupId>
  <artifactId>riak-client</artifactId>
  <version>VERSION</version>
</dependency>

<dependency>
  <groupId>org.apache.curator</groupId>
  <artifactId>curator-framework</artifactId>
  <version>VERSION</version>
</dependency>
```

In a leiningen project, add the following to the dependencies section of your project.clj:

``` clojure
;; in collection under :dependencies key
[com.riak.riak/riak-client "VERSION"]
[org.apache.curator/curator-framework "VERSION"]
```

Install the license key as described [here](../../../05-operation/01-pro/01-storage-services/storage-services.md) and you are ready to go.

If you are accessing Riak via HTTPS, you must provide a Java [TrustStore](https://docs.oracle.com/cd/E21454_01/html/821-2544/cnfg_ssl-overview_c.html) for the transactor to use when connecting to storage. The TrustStore must contain one or more certificates that can be used to verify the identity of the storage node(s) the transactor is connecting to. You must also provide a Java KeyStore that the transactor will use to establish an SSL connection with peers. You specify the TrustStore and KeyStore using the standard Java system properties:

``` sh
bin/transactor -Djavax.net.ssl.trustStore=path-to-truststore
-Djavax.net.ssl.trustStorePassword=password-for-truststore
-Djavax.net.ssl.keyStore=path-to-keystore
-Djavax.net.ssl.keyStorePassword=password-for-keystore my-transactor.properties
```

<a id="outline-container-troubleshooting"></a>

<a id="troubleshooting"></a>

### Troubleshooting Riak

<a id="text-troubleshooting"></a>

The following error message indicates that the transactor or peer cannot communicate with the storage nodes. Verify that you can connect to the storage nodes using other tools; for instance a Cassandra cqlsh. Also verify that the TrustStore contains the certificates necessary for connecting to the storage nodes.

Typical error message when unable to connect to Riak via HTTPS:

``` java
javax.net.ssl.SSLPeerUnverifiedException: peer not authenticated
```

<a id="outline-container-provisioning-couchbase"></a>

<a id="provisioning-couchbase"></a>

## Provisioning Couchbase

<a id="text-provisioning-couchbase"></a>

Using Couchbase as a storage requires a Couchbase cluster. If you already have one running, you can use the one you have. Each Datomic system needs its own bucket in the Couchbase cluster.

To install Couchbase, follow the [directions](https://www.couchbase.com/downloads) on the Couchbase site. Note that if you are running on a Mac you might want to up the maxfiles limit in /etc/launchd.conf. (e.g. with an entry like: limit maxfiles 10000 100000)

Start the Couchbase cluster and use their UI to create a bucket for your Datomic system.

Next, setup your transactor properties file:

- Copy the *config/samples/couchbase-transactor-template.properties* file to another location and give it a new name, for instance, *couchbase-transactor.properties*
- set the entries for couchbase-host and couchbase-bucket. You can choose any member of the cluster, the peers will discover the other cluster members through that.
- if you set a password on the bucket, set couchbase-password accordingly

Install the license key as described [here](../../../05-operation/01-pro/01-storage-services/storage-services.md) and you are ready to go.

<a id="outline-container-provisioning-infinispan"></a>

<a id="provisioning-infinispan"></a>

## Provisioning Infinispan memory cluster

<a id="text-provisioning-infinispan"></a>

The steps to provision an [Infinispan](https://www.jboss.org/infinispan) memory cluster as your Storage Service are:

- download Infinispan
- configure a namedCache
- launch with hotrod

There are scripts and configuration files for the last two steps in Datomic distribution's *bin/inf* directory.

The scripts need to know where Infinispan is installed. Export the location as an environment variable:

``` sh
export ISPN_HOME=<path to infinispan install directory>
```

The *start-mem.sh* script launches a single node memory cache described by the *infinispan-mem.xml* config file.

``` sh
bin/inf/start-mem.sh
```

The *start-mem-3.sh* script launches a three node memory cache described the by the *infinispan-mem-distributed-(1\|2\|3).xml* config files.

``` sh
bin/inf/start-mem-3.sh
```

In both cases, all the infinispan processes run locally. For a production environment, run the *startServer.sh* script directly (see the other scripts for arguments) to launch nodes on separate servers.

You can use the *listall.sh* and *killall.sh* scripts to list and shutdown all infinispan processes on a server, respectively.

Now you are ready to [install your license key](../../../05-operation/01-pro/01-storage-services/storage-services.md).

<a id="outline-container-cassandra"></a>

<a id="cassandra"></a>

## Provisioning Cassandra

<a id="text-cassandra"></a>

Using Cassandra as a storage service requires a cluster of at least 3 nodes running an up-to-date release of Cassandra. Datomic supports 2.0.X, 2.1.X, and 3.0.X versions of Cassandra. Refer to the version of the Cassandra driver in the *provided* scope in the *pom.xml* in the Datomic directory and the [Datastax Java Driver Compatibility matrix](https://docs.datastax.com/en/developer/driver-matrix/doc/common/driverMatrix.html?scroll=driverMatrix__java-driver-matrix) to verify Datastax/Cassandra compatibility for a specific release of Datomic. The cluster needs to be configured to support the CQL native transport (this is on by default in new releases of Cassandra). If you have an existing cluster that meets these requirements, you can use it. Otherwise, you need to configure one following the instructions on the Cassandra site.

Note that Datomic does not support running on a Cassandra cluster that spans datacenters.

While Cassandra replica factor settings are entirely up to you, is highly recommended to always have a minimum of three nodes in the cluster size, a replica factor of 3.

Once a cluster is configured, you must provision a keyspace and table (column family) for Datomic to use. You can do this using the CQL scripts provided in the distribution's *bin/cql* directory. You can execute the scripts using the *cqlsh* tool provided by Cassandra (use an appropriate superuser username and password, if required):

noslide

``` sh
cqlsh -f bin/cql/cassandra-keyspace.cql -u cassandra -p cassandra
```

noslide

``` sh
cqlsh -f bin/cql/cassandra-table.cql -u cassandra -p cassandra
```

Datomic provides optional support for Cassandra's internal username/password mechanism for authentication and authorization. If your cluster is configured to require authentication and authorization, you must also create a user for Datomic:

noslide

``` sh
cqlsh -f bin/cql/cassandra-user.cql -u cassandra -p cassandra
```

This script creates the user and grants it access to the Datomic keyspace.

Note that if you are using Cassandra 3.X the cqlsh tool may require you to explicitly specify the cql version with the command line flag:

noslide

``` sh
--cqlversion=3.4.0
```

Next, setup your transactor properties file:

- Copy the *config/samples/cassandra-transactor-template.properties* file to another location and give it a new name, for instance, *cassandra-transactor.properties*.
- Set the entry for *cassandra-host* to refer to a member of the cluster.
- If your cluster uses a non-standard port for the CQL native transport, set *cassandra-port*.
- If your cluster is configured to require authentication and authorization, set *cassandra-user* and *cassandra-password*.
- If your Cassandra cluster is configured with the necessary certificates to support SSL, and verified it works with a simple client (e.g., *cqlsh*), you can configure the transactor to use SSL by setting *cassandra-ssl* to true. See the [Cassandra docs](https://docs.datastax.com/en/security/6.0/security/encryptClientNodeSSL.html) for more information.
- You can optionally provide *cassandra-cluster-callback*, whose value is a name identifying either a Java static method (e.g. my.app.Cassandra.buildCluster), or a clojure function (e.g. my.app/build-cluster). This method/function takes as its single argument a map containing the above parameters, and which returns an instance of [Cassandra Cluster](https://docs.datastax.com/en/drivers/java/2.0/com/datastax/driver/core/Cluster.html). Note that the argument type for this method is Object, e.g.

``` java
import com.datastax.driver.core.Cluster;
import datomic.Util;
import java.util.Map;

public class DatomicCassandra {
  public static Cluster build(Object args) {
    Map <Object, Object> params = (Map<Object,Object>) args;
    Cluster.Builder cluster = Cluster.builder();
    cluster.addContactPoint((String)params.get(Util.read(":host")));
    cluster.withPort((Integer)(params.get(Util.read(":port"))));
    cluster.withCredentials((String)params.get(Util.read(":user")),
                            (String)params.get(Util.read(":password")));

    // Set other cluster options here

    return cluster.build();
  }
}
```

In your peer project, add a dependency for the [DataStax Java Driver for Apache Cassandra](https://docs.datastax.com/en/developer/java-driver/4.17/manual/core/).

In a tools-deps based project, add the following to the deps section of your *deps.edn*:

``` clojure
com.datastax.oss/java-driver-core-shaded {:mvn/version "4.17.0"}
```

In a maven based build, add the following snippet to the dependencies section of your *pom.xml*:

``` xml
<dependency>
  <groupId>com.datastax.oss</groupId>
  <artifactId>java-driver-core-shaded</artifactId>
  <version>4.17.0</version>
</dependency>
```

In a leiningen project, add the following to the dependencies section of your *project.clj*:

noslide

``` clojure
;; in collection under :dependencies key
[com.datastax.oss/java-driver-core-shaded "4.17.0"]
```

\*

<a id="outline-container-cassandra2"></a>

<a id="cassandra2"></a>

## Provisioning Cassandra2

<a id="text-cassandra2"></a>

The Cassandra2 storage service provides improved support for large datasets. Cassandra2 breaks large segments into chunks, avoiding performance issues and operational problems that can occur when index segments run up against [Cassandra's limits](https://cwiki.apache.org/confluence/display/CASSANDRA2/CassandraLimitations).

> If you are happily using Cassandra with your existing dataset, you need not consider Cassandra2.

Cassandra2 works exactly like Cassandra, **except**

- The Cassandra schema is different. Follow the same [setup instructions](#cassandra) as for Cassandra, but use the cql files with a '2' in the name.
- The protocol URI is different. Follow the same connection instructions as for Cassandra, but use the `cass2:` instead of `cass:` in your [connection URI](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/connect).

Note that Cassandra and Cassandra2 are different storage services! You can use [backup and restore](../../../05-operation/01-pro/08-backup-and-restore/backup-and-restore.md) to migrate databases from Cassandra to Cassandra2 (or between any storage services).
