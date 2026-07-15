<a id="content"></a>

<a id="using-the-sql-cli"></a>

# Using the SQL CLI

Use the SQL CLI to validate your [analytics configuration](../03-cloud-configuration/cloud-configuration.md) before moving on to other [analytics tools](../16-analytics-tools/analytics-tools.md). The CLI is a fully-featured interactive SQL environment in its own right.

> **Important:** Presto has been renamed to Trino.

<a id="outline-container-install"></a>

<a id="install"></a>

## Installing the CLI

<a id="text-install"></a>

- [Download the Presto CLI](https://repo1.maven.org/maven2/io/prestosql/presto-cli/348/presto-cli-348-executable.jar)
- Rename the jar to `presto`
- `chmod +x presto` to make the jar executable.

<a id="outline-container-use"></a>

<a id="use"></a>

## Using the CLI

<a id="text-use"></a>

You will typically launch the SQL CLI with three arguments:

- The required `--server` argument specifies the analytics server address. Because you are connecting through the local `datomic access` proxy this will be `localhost:8989`.
- The optional `--catalog` argument must match a [catalog](../03-cloud-configuration/cloud-configuration.md) configured for your system.
- The optional `--schema` argument must be the name of a Datomic database.

The `catalog` and `schema` arguments are defaults for queries that do not explicitly name a catalog and schema, so that in your queries you can use table names directly, e.g. `country` instead of `tomhanks.mbrainz.country`:

```
./presto --server localhost:8989 --catalog <my-catalog> --schema <db-name>
```

A SQL prompt will be displayed:

```
presto>
```

<a id="outline-container-validate-configuration"></a>

<a id="validate-configuration"></a>

## Validating Configuration

<a id="text-validate-configuration"></a>

The examples below presume a Datomic system named `tomhanks` with a database named `mbrainz`, and a SQL CLI launched with:

```
./presto --server localhost:8989 --catalog tomhanks --schema mbrainz
```

<a id="outline-container-catalog-query"></a>

<a id="catalog-query"></a>

### Catalogs

<a id="text-catalog-query"></a>

The following query shows all [catalogs](../01-analytics-concepts/analytics-concepts.md#sql-mapping):

``` sql
select * from system.metadata.catalogs;
```

``` sql
=>
catalog_name | connector_id
--------------+--------------
 analytics    | analytics
 sample       | sample
 system       | system
 catalog_name | connector_id 
```

A `system` catalog will be displayed, in addition to one entry per [catalog properties file](../03-cloud-configuration/cloud-configuration.md). In the example above, the Datomic catalog name is `tomhanks`.

<a id="outline-container-schema-query"></a>

<a id="schema-query"></a>

### Show Schemas

<a id="text-schema-query"></a>

The following query shows all the [schemas](../01-analytics-concepts/analytics-concepts.md#sql-mapping) in the default catalog:

```
show schemas;
```

``` sql
=>
       Schema       
--------------------
 information_schema 
 mbrainz   
```

An `information_schema` catalog will be displayed, in addition to one schema per [exposed Datomic database](../03-cloud-configuration/cloud-configuration.md). In the example above, the `tomhanks` system has a single database named `mbrainz`.

<a id="outline-container-tables-query"></a>

<a id="tables-query"></a>

### Show Tables

<a id="text-tables-query"></a>

The following query shows all the [tables](../01-analytics-concepts/analytics-concepts.md#sql-mapping) in the default schema:

``` sql
show tables;
```

``` sql
=>
           Table           
---------------------------
 abstractrelease           
 abstractrelease_x_artists 
 artist                    
 artist_gender             
 artist_type               
 country                   
 db__attrs                 
 db__idents               
 (continues...)
```

`db__attrs` and `db__idents` will be displayed, in addition to any tables you have configured via a [Metaschema](../01-analytics-concepts/analytics-concepts.md#metaschemas).

<a id="outline-container-table-query"></a>

<a id="table-query"></a>

### Describe a Table

<a id="text-table-query"></a>

The following query describes a table named `country` in the default schema:

``` sql
describe country;
```

``` sql
=>
 Column |  Type   | Extra | Comment 
--------+---------+-------+---------
 code   | varchar |       |         
 name   | varchar |       |         
 db__id | bigint  |       |         
```

<a id="outline-container-query"></a>

<a id="query"></a>

### Query

<a id="text-query"></a>

This is an opportune time to verify your dashboard.

``` sql
select * from track_x_artists limit 10;
```

``` sql
select * from country limit 10;
```

<a id="outline-container-try"></a>

<a id="try"></a>

## More Things to Try

<a id="text-try"></a>

Try some of the [system commands](https://prestosql.io/docs/current/connector/system.html) to see what is present in the system.

You can access more than one database (or even more than one catalog) by using fully qualified table names in your SQL, e.g. `[catalog].[database].[table]`. You can also write queries that join across different databases or catalogs.
