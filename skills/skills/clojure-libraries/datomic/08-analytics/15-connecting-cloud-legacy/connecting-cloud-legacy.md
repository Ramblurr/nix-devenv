<a id="content"></a>

<a id="connecting"></a>

# Connecting

This page covers:

- [Connecting to the access gateway](#connect)
- [Testing the analytics connection](#test)

<a id="outline-container-prerequisites"></a>

<a id="prerequisites"></a>

## Prerequisites

<a id="text-prerequisites"></a>

This page assumes that an administrator has already:

- [Started a Datomic System](../../05-operation/02-cloud/02-start-a-system/start-a-system.md)
- [Configured user access](../../03-tutorials/03-cloud-getting-started/02-configure-access/configure-access.md)
- [Configured analytics](../03-cloud-configuration/cloud-configuration.md)

Before you connect, you need to:

- Install the [AWS CLI](../../05-operation/02-cloud/11-how-to/how-to.md#install-cli) version 1.11.170 or greater
- Install the [Datomic CLI tools](../../05-operation/02-cloud/07-cli-tools/cli-tools.md)
- Configure a shell environment with [AWS access keys](../../05-operation/02-cloud/11-how-to/how-to.md#aws-access-keys) for Datomic
- Know the [region and name](../../05-operation/02-cloud/11-how-to/how-to.md#system-name) of the Datomic system you want to connect to

<a id="outline-container-connect"></a>

<a id="connect"></a>

## Connecting

<a id="text-connect"></a>

Use the [Datomic tools](../../05-operation/02-cloud/07-cli-tools/cli-tools.md#analytics) to create an analytics connection, passing in the arguments `analytics` and your Datomic [system name](../../05-operation/02-cloud/11-how-to/how-to.md#system-name).

```
datomic analytics access <system-name>
```

<a id="outline-container-test"></a>

<a id="test"></a>

## Testing Your Connection

<a id="text-test"></a>

Test your analytics connection in two different ways:

- Browse to the analytics dashboard by visiting [localhost:8989](http://localhost:8989/) in a web browser. A monitoring dashboard will be displayed.
- Install the [SQL CLI](../04-sql-cli/sql-cli.md) and use it to validate your configuration.

Once you have verified your connection via the dashboard and the SQL CLI, you can explore your data from the CLI or set up and run the [analytics tools](../16-analytics-tools/analytics-tools.md) of your choice.
