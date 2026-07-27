<a id="content"></a>

<a id="split-cloudformation-stacks"></a>

# Split CloudFormation Stacks

This page explains how to convert a master stack system into a split stack system.

<a id="outline-container-rationale"></a>

<a id="rationale"></a>

## Rationale

<a id="text-rationale"></a>

> This section only applies to [Datomic 990-9202](../../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and lower. Newer versions of Datomic Cloud do not use the Master stack templates.

A Datomic Cloud system comprises at least 2 CloudFormation stacks per [AWS best practice guidelines](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html#organizingstacks):

- One storage resource stack
- One or more compute stacks

These stacks are nested under a master stack. The master stack makes various operational tasks more difficult. For production operation, use a *split stack* system, i.e. separate top-level storage and compute stacks.

There are two ways to run a split stack system:

- Create a [split stack](../02-start-a-system/start-a-system.md) system from scratch
- Convert a [master stack](../02-start-a-system/start-a-system.md) system into a split stack system, as the instructions below

<a id="outline-container-howto"></a>

<a id="howto"></a>

## How to Split Datomic Stacks

<a id="text-howto"></a>

The following steps convert a Datomic system from the master stack setup to the split stack setup. There are two steps:

- [Delete the master stack](#delete-master)
- [Recreate the stacks](#recreate)

<a id="outline-container-delete-master"></a>

<a id="delete-master"></a>

### Delete the Master Stack

<a id="text-delete-master"></a>

Deleting the master stack will make your system temporarily unavailable, but does not harm your data:

- Select the root stack for your system in the [CloudFormation console](https://console.aws.amazon.com/cloudformation/home?#/stacks?filter=active). The root stack will have a *Stack Name* that is the same as your [system name](../11-how-to/how-to.md#system-name).
- Click "Delete" from the menu bar. Confirm this in the Delete Stack popup, then wait for the stack deletion to complete. This can take 10 minutes or more.

<a id="outline-container-recreate"></a>

<a id="recreate"></a>

### Recreating Stacks

<a id="text-recreate"></a>

The process of recreating the stacks is the same as [starting a new split stack system](../02-start-a-system/start-a-system.md#storage) with the following exceptions:

- Storage stack name is the name of the system that you just deleted
- Reuse existing storage must be set to "True"

The [split stack instructions](../02-start-a-system/start-a-system.md#storage) are annotated where necessary for recreating your stack.
