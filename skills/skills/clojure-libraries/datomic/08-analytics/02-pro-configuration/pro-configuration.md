<a id="content"></a>

<a id="configuration"></a>

# Configuration

> Analytics support requires Datomic On-Prem version 0.9.5656 or greater.

To set up analytics support the first time, perform the following steps in order:

- Create [configuration files](#first-configuration)
- Configure a [catalog](#configuring-catalog)
- Configure one or more [metaschema(s)](#configuring-metaschema)

Once analytics support is configured, you can use the system by following the [connecting documentation](../14-connecting-pro/connecting-pro.md).

Metaschema files can be [updated](#configuring-metaschema) without restarting the Presto server – the changes will be adopted dynamically (in 1 minute or less).

Changes to catalog and properties files require a restart of the presto server.

<a id="outline-container-first-configuration"></a>

<a id="first-configuration"></a>

## First Configuration

<a id="text-first-configuration"></a>

Analytics support requires you to configure a [catalog](../01-analytics-concepts/analytics-concepts.md#sql-mapping), including at least one [metaschema](../01-analytics-concepts/analytics-concepts.md#metaschemas) file. The catalog allows you to configure the set of databases that are available for analytics, while the Metaschema is responsible for driving the mapping between Datomic attributes and Presto tables and columns.

A set of sample config files is on the unzipped Datomic distribution under `presto-server/etc-samples`:

```
presto-server/etc-samples/
├── catalog
│   └── analytics.properties
├── config.properties
├── jvm.config
└── node.properties
```

Presto can be run with these files, however, it's recommended that you make a copy of them elsewhere. Configure your Presto instance to use your copies.

<a id="outline-container-system-config"></a>

<a id="system-config"></a>

## System

<a id="text-system-config"></a>

The sample `config.properties` and `jvm.config` [files](#first-configuration) include default settings that should be reviewed and modified for the machine Presto is running on.

The `node.properties` [file](#first-configuration) uses the default node.id. You should generate a new id and replace it in the properties file. This is also a good time to update the node.data line to a local directory you wish to use for data storage.

<a id="outline-container-configuring-catalog"></a>

<a id="configuring-catalog"></a>

## Catalog

<a id="text-configuring-catalog"></a>

The `catalog/analytics.properties` [file](#first-configuration) is a sample catalog file. This file will need to be updated with the *secret-key* and *access-key* used to run your [peer server](../../05-operation/01-pro/16-peer-server/peer-server.md).

The optional list of exposed databases (`datomic.databases`) in the catalog enables you to select only specific databases from this system as accessible for analytics. If you leave this list commented, **all** databases in the system will be accessible via analytics.

If you have a large number of databases and you do not limit the set of exposed databases, some tools may automatically query **all** databases in the system, which can result in a significant query load on the analytics server and the Peer Server. Limiting the set of exposed databases to those specifically desired for analytics is highly recommended.

All properties specified in \*.properties [files](#first-configuration) can be passed as command line parameters, e.g. you can provide a node.id without editing the node.properties file with `bin/presto run -Dnode.id=<uuid>`. Jvm.config settings cannot be passed this way.

Changes to the catalog and any `*.properties` files require restarting the [Presto server](../14-connecting-pro/connecting-pro.md#running).

<a id="outline-container-jdbc-metadata"></a>

<a id="jdbc-metadata"></a>

## Enabling JDBC Metadata

<a id="text-jdbc-metadata"></a>

Many analytics tools provide the ability to automatically explore all of the tables in your system. Such exploration involves issuing one *(or many)* JDBC metadata queries, forcing the load of every table in your system.

Because these automatic queries can be so expensive, they are disabled by default. To enable JDBC metadata queries, explicitly enumerate the Datomic databases you want to query with the `datomic.databases` property [described above](#configuring-catalog).

<a id="outline-container-configuring-metaschema"></a>

<a id="configuring-metaschema"></a>

## Metaschema

<a id="text-configuring-metaschema"></a>

Place one or more [Metaschema EDN files](../01-analytics-concepts/analytics-concepts.md#metaschemas) in the `etc-path/datomic` [subdirectory](#first-configuration). Changes to Metaschema files will be adopted dynamically (in 1 minute or less) without restarting the Presto server.

- Check [Metaschema grammar](../05-metaschema/metaschema.md) for more information on writing your Metaschema.
- Check [connecting](../14-connecting-pro/connecting-pro.md) documentation for details on running and connecting to analytics support.
