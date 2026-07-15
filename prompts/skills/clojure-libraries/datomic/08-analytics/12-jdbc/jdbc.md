<a id="content"></a>

<a id="jdbc"></a>

# JDBC

<a id="outline-container-overview"></a>

<a id="overview"></a>

## Overview

<a id="text-overview"></a>

The JDBC analytics connection is read-only and intended for analytics applications and is not low latency. Do not consider it a substitute for the [client API](../../04-apis/04-client-api/additional-client-api-reference/additional-client-api-reference.md) for programmatic access to Datomic.

<a id="outline-container-driver"></a>

<a id="driver"></a>

## Presto JDBC Driver

<a id="text-driver"></a>

To use analytics support from JDBC, add the [Presto JDBC driver](https://prestosql.io/docs/current/installation/jdbc.html) to your classpath. For applications, add this dependency to your Maven XML:

``` xml
<dependency>
    <groupId>io.prestosql</groupId>
    <artifactId>presto-jdbc</artifactId>
    <version>348</version>
</dependency>
```

If you are using a tool such as [DBeaver](https://dbeaver.io/), specify version 348 of the driver.

<a id="outline-container-connecting"></a>

<a id="connecting"></a>

## Connecting

<a id="text-connecting"></a>

You can connect to a running analytics service via JDBC using the URI format with the command below. Replace `<host>`, `<port>`, `<catalog>`, `<schema>`, and `<user>` as appropriate for your analytics system:

``` sh
jdbc:presto://<host>:<port>/<catalog>/<schema>?user=<user>
```

Consider the following:

- `host` and `port` are the host and port of your [Presto server](../03-cloud-configuration/cloud-configuration.md#start).
- `catalog` is the name of your [catalog](../03-cloud-configuration/cloud-configuration.md).
- `schema` is the name of your Datomic database.
- `user` is not currently used, but some tools may require that you specify it.

> For `catalog` and `schema`, keep in mind the [naming conventions](../05-metaschema/metaschema.md#naming-conventions).
