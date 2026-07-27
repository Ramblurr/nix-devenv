<a id="content"></a>

<a id="get-connected"></a>

# Get Connected

> This page only applies to [Datomic 781-9041](../../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and lower.

This page walks your through configuring Client API connectivity to a Datomic system from outside the Datomic VPC. This takes two steps:

- [connect to the access gateway](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md#client-access)
- [test the access gateway connection](#test-access-gateway)

> The latest Datomic Cloud [setup process](../../../05-operation/02-cloud/02-start-a-system/start-a-system.md) does not require these steps.

<a id="outline-container-prerequisites"></a>

<a id="prerequisites"></a>

## Prerequisites

<a id="text-prerequisites"></a>

This page assumes that an administrator has already:

- [started a Datomic System](../../../05-operation/02-cloud/02-start-a-system/start-a-system.md)
- [configured user access](../02-configure-access/configure-access.md)

Before you configure Client API connectivity to a Datomic database from outside the VPC, you need to:

- Install [Clojure](https://clojure.org/guides/getting_started) 1.9 or later.
- Install the [AWS CLI](../../../05-operation/02-cloud/11-how-to/how-to.md#install-cli) version 1.11.170 or greater.
- Install the [Datomic CLI Tools](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md)
- Configure a shell environment with [AWS access keys](../../../05-operation/02-cloud/11-how-to/how-to.md#aws-access-keys) for Datomic
- Know the [region and name](../../../05-operation/02-cloud/11-how-to/how-to.md#system-name) of the Datomic System you want to connect to

<a id="outline-container-access-gateway"></a>

<a id="access-gateway"></a>

## Connect to the Access Gateway

<a id="text-access-gateway"></a>

To connect to the access gateway, run the [datomic access](../../../05-operation/02-cloud/07-cli-tools/cli-tools.md#client-access) command to create an SOCKS proxy connection, passing your [system name](../../../05-operation/02-cloud/11-how-to/how-to.md#system-name):

```
datomic client access <system>
```

The script will continue to run once launched.

<a id="outline-container-test-access-gateway"></a>

<a id="test-access-gateway"></a>

## Test Access Gateway Connection

<a id="text-test-access-gateway"></a>

Run the following command to test your system's ability to reach Datomic through the SOCKS proxy, replacing `[system]`, `[region]`. and `[port]` with your [system-name, region](../../../05-operation/02-cloud/11-how-to/how-to.md#system-name) and port.

```
curl -x socks5h://localhost:8182 http://entry.[system].[region].datomic.net:8182/
```

On success, this command will return text like:

```
{:s3-auth-path [bucket-name]}
```

Any other response indicates a failure to connect. Carefully review the prerequisites and steps on this page. If you feel that you have completed each step correctly, see the [troubleshooting documentation](../../../05-operation/02-cloud/13-cloud-troubleshooting/cloud-troubleshooting.md#troubleshooting-socks).

If you are trying Datomic for the first time, a good next step is the [Client API Tutorial](../../02-client-tutorial/01-client-api/client-api.md).
