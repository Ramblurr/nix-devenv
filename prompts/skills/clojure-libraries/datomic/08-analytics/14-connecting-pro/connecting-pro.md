<a id="content"></a>

<a id="connecting"></a>

# Connecting

It's necessary to have a running [peer server](../../05-operation/01-pro/16-peer-server/peer-server.md) that is serving the database(s) you intend to connect to for analytics.

<a id="outline-container-running"></a>

<a id="running"></a>

## Running Presto

<a id="text-running"></a>

> Presto server requires Java 11.

- Launch your Presto server from the root of the Datomic distribution with the command below. Note that `<path-to-your-etc-dir>` is the path to

your [config etc](../03-cloud-configuration/cloud-configuration.md) directory:

``` sh
bin/presto run --etc-dir=<path-to-your-etc-dir>
```

Running `bin/presto -h` provides a list of the options that can be passed to the Presto launcher script.

Restart the Presto server any time you change your catalog files. Changes to Metaschema files are adopted dynamically, in 1 minute or less.

Check the [Metaschema documentation](../01-analytics-concepts/analytics-concepts.md#metaschemas) and [Metaschema grammar](../05-metaschema/metaschema.md) for more information on writing your Metaschema.

You can view a monitoring dashboard by visiting `localhost:8989` in a web browser.

The following pages include details on connecting to your analytics endpoint using a variety of tools:

- [SQL CLI](../04-sql-cli/sql-cli.md)
- [Metabase](../07-metabase/metabase.md)
- [R](../08-r/r.md)
- [Jupyter](../10-jupyter/jupyter.md)
- [Superset](../11-superset/superset.md)
- [Other tools](../13-other-tools/other-tools.md)
