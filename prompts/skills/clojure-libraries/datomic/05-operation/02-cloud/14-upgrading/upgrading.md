<a id="content"></a>

<a id="upgrading"></a>

# Upgrading

Datomic Cloud is designed to minimize the upgrade effort, allowing rolling upgrades with zero downtime. To plan and implement an upgrade, you need to:

- Be running [split CloudFormation stacks](../16-splitting-stacks/splitting-stacks.md)
- [Know what version you are running](#know-your-version)
- [Choose a release](#choose-release)
- [Perform the upgrade](#perform-release)

In most situations, [never downgrade Datomic](#do-not-downgrade).

<a id="outline-container-know-your-version"></a>

<a id="know-your-version"></a>

## Know What Version You Are Running

<a id="text-know-your-version"></a>

- [Datomic Cloud releases](../../../11-releases/releases.md) have a version number of the form `[CloudFormation-revision]-[code-revision]`.
- A Datomic system comprises one storage stack, plus a separate compute stack for each compute group, each with its own version
- A storage stack does not manage any code, and so its version information includes only a CloudFormation revision
- A compute stack has both a CloudFormation revision and a code revision
- All the stacks for a system should normally be running the same version of Datomic, but this is not mandatory and will not be the case during an upgrade

You can query the revisions for all stacks for a system from the CLI or inspect them in the AWS console:

<a id="outline-container-from-the-cli"></a>

<a id="from-the-cli"></a>

### From the CLI

<a id="text-from-the-cli"></a>

- The [`datomic cloud list-systems`](../07-cli-tools/cli-tools.md#list-systems) command lists all systems, with the storage CloudFormation revision under the `storage-cft-version` key.
- The [`datomic system list-instances <system>`](../07-cli-tools/cli-tools.md) command lists all compute instances for a particular system. Each instance will have a `group-cft-version` key with the CloudFormation revision that launched the instance, and a `group-cloud-version` key with the code revision that the instance is currently running.

<a id="outline-container-from-the-aws-console"></a>

<a id="from-the-aws-console"></a>

### From the AWS Console

<a id="text-from-the-aws-console"></a>

- Storage stacks have a CloudFormation revision number in the `DatomicCFTVersion` output
- Compute stacks have a CloudFormation revision number in the `DatomicCFTVersion` output, and a code revision number in the `DatomicCloudVersion` output

To view the outputs for a CloudFormation stack:

- Select the name of your system stack in the [CloudFormation console](https://console.aws.amazon.com/cloudformation/home?r#/stacks?filter=active)
- Click on the outputs tab

<a id="outline-container-choose-release"></a>

<a id="choose-release"></a>

## Choose a Release

<a id="text-choose-release"></a>

The releases page provides three resources that can help you decide when and how to upgrade:

- The [critical notices](../../../11-releases/releases.md) section contains critical notices for all users. Always read this section.
- The [release history](../../../11-releases/releases.md) table includes a summary column with a brief description of each release.
- The [release notes](../../../11-releases/releases.md) provides a comprehensive list of changes in each release.

Do not [downgrade to older versions](#do-not-downgrade) of Datomic Cloud.

<a id="outline-container-perform-release"></a>

<a id="perform-release"></a>

## Perform an Upgrade

<a id="text-perform-release"></a>

Before any upgrade, read the [critical notices](../../../11-releases/releases.md) for all releases between your current release(s) and the release(s) you are upgrading to. These notices may override the generic instructions below.

The documentation for each release lists an upgrade type, Make sure you perform the correct type of upgrade, which can be one of:

- A [compute upgrade](#compute-only-upgrade)
- A [storage upgrade](#storage-only-upgrade)
- A [storage and compute upgrade](#storage-and-compute)

<a id="outline-container-storage-and-compute"></a>

<a id="storage-and-compute"></a>

## Storage and Compute Upgrade

<a id="text-storage-and-compute"></a>

If **both** storage and compute are being upgraded:

- [Upgrade storage](#storage-only-upgrade) first
- Then [upgrade compute](#compute-only-upgrade)

<a id="outline-container-storage-only-upgrade"></a>

<a id="storage-only-upgrade"></a>

## Storage Upgrade

<a id="text-storage-only-upgrade"></a>

To update a Storage stack:

- Open the [CloudFormation console](http://console.aws.amazon.com/cloudformation/home?#/stacks?filter=active)

- Select your stack via the checkbox or radio button.

- Click the "Update" button.

- Select "Specify an Amazon S3 template URL" and enter the CloudFormation template URL for the version you wish to upgrade to (check the [release page](../../../11-releases/releases.md) for all versions) then click "Next".

- On the "Specify Details" screen, set the "Reuse Existing Storage" option to *true*:

  [![reuse-existing-storage-true.png](../../../images/reuse-existing-storage-true.png)](../../../images/reuse-existing-storage-true.png)

- On the "Options" screen, leave all options unchanged.

- On the "Review" screen, click the checkbox stating "I acknowledge that AWS CloudFormation might create IAM resources with custom names" and click "Update".

<a id="outline-container-compute-only-upgrade"></a>

<a id="compute-only-upgrade"></a>

## Compute Upgrade

<a id="text-compute-only-upgrade"></a>

If you have more than one compute group, upgrade all of them. Upgrade the primary compute group first and then upgrade your query groups. It is ok to upgrade the query groups in parallel.

To update a Compute Stack:

- Open the [CloudFormation console](http://console.aws.amazon.com/cloudformation/home?#/stacks?filter=active).
- Select your stack via the checkbox or radio button.
- Click the "Update" button.
- Select "Specify an Amazon S3 template URL:" and enter the CloudFormation template URL for the version that you wish to upgrade to (see [Release page](../../../11-releases/releases.md) for all versions) then click "Next".
- On the "Specify Details" screen, leave all options unchanged.
- On the "Options" screen, leave all options unchanged.
- On the "Review" screen, click the mandatory checkboxes that you agree with.

<a id="outline-container-do-not-downgrade"></a>

<a id="do-not-downgrade"></a>

## Do Not Downgrade

<a id="text-do-not-downgrade"></a>

Generally speaking, you should never downgrade Datomic CloudFormation templates.

- Newer versions are better: They may contain important fixes.
- Newer versions are compatible: They continue to support the entirety of the API.
- Older versions may be incapable of correctly handling newer features.
- Our support team is better able to help if you are running a recent version.

If you have a need to downgrade Datomic, please [contact support](https://www.datomic.com/support.html) first, and let the Datomic team advise you.
