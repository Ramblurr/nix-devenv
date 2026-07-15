<a id="content"></a>

<a id="aws-access-control"></a>

# AWS Access Control

Datomic peers and transactors requiring access to services provided by AWS (DDB, S3, Cloudwatch) must be authorized to do so. Datomic supports using roles to grant access to specific AWS resources. Use of roles is based on [AWS identity and access management](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html).

> The use of IAM user access keys is deprecated except when used for the initial configuration and deployment steps (e.g. *ensure-transactor* or *create-cf-stack*). Do not use user access keys to provide resource access to peer and transactor processes directly.

<a id="outline-container-using-iam-roles"></a>

<a id="using-iam-roles"></a>

## Using IAM Roles

<a id="text-using-iam-roles"></a>

Using IAM roles is the preferred method of granting resource access to Datomic peers and transactors running in EC2. Using roles obviates the need for Datomic processes to store sensitive user credentials in memory, and the need for users to store these credentials in plain text in source code or config files.

EC2 instances can run as an IAM role specified at launch time. Each role can be given a set of policies granting access to specific AWS resources.

<a id="outline-container-required-role-policies"></a>

<a id="required-role-policies"></a>

### Required Role Policies

<a id="text-required-role-policies"></a>

The specific role policies required by the transactor and peer library are documented in [setting up storage services](../01-storage-services/storage-services.md) and [backup and restore](../08-backup-and-restore/backup-and-restore.md).

<a id="outline-container-using-iam-user-access-keys"></a>

<a id="using-iam-user-access-keys"></a>

## Deprecated: Using IAM User Access Keys

<a id="text-using-iam-user-access-keys"></a>

AWS credentials can still be provided as environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY) or as Java properties (aws.accessKeyId, aws.secretAccessKey). Transactor and peer processes, including backup and restore, will implicitly use credentials provided this way.

Datomic also continues to support passing AWS credentials in URIs as query parameters (e.g. in ddb database and S3 backup URIs), in transactor properties files, and in the S3 URIs passed as arguments to the *bin/backup* and *bin/restore* commands, though these methods are deprecated.

<a id="outline-container-migrating-access-keys"></a>

<a id="migrating-access-keys"></a>

## Migrating from User Access Keys to IAM Roles

<a id="text-migrating-access-keys"></a>

Check [migrating to IAM roles](../../../10-resources/06-legacy-resources/04-migrate-to-roles/migrate-to-roles.md).
