<a id="content"></a>

<a id="migrating-to-iam-roles"></a>

# Migrating to IAM Roles

In earlier versions of Datomic, the transactor and peers used IAM user access keys to gain access to AWS resources. The transactor and peer library have have now been updated to work with IAM roles, as described in [Setting up Storage Services](../../../05-operation/01-pro/01-storage-services/storage-services.md). Roles are the preferred mechanism for securing access to AWS resources when running on EC2 and all future work will be done with them. IAM user access keys will continue to work to support running in environments other than EC2, but EC2 users should migrate to using roles as soon as it's convenient. Please see [AWS Access Control](../../../05-operation/01-pro/14-aws-access-control/aws-access-control.md) for more information.

<a id="outline-container-migrating-transactor"></a>

<a id="migrating-transactor"></a>

## Migrating the transactor

<a id="text-migrating-transactor"></a>

To migrate a transactor running on EC2 to use roles, do the following:

- Edit your transactor properties file.
- Add a *aws-transactor-role* property. You can leave the value blank or specify the name of a role to use. If the role does not exist, it will be created for you later in this process.
- Comment out the *aws-dynamodb-user*, *aws-dynamodb-access-key-id* and *aws-dynamodb-secret-key* properties.
- If S3 log rotation is enabled, comment out the *aws-s3-log-user*, *aws-s3-log-access-key-id* and *aws-s3-log-secret-key* properties.
- If CloudWatch metrics are enabled, comment out the *aws-cloudwatch-user*, *aws-cloudwatch-access-key-id* and *aws-cloudwatch-secret-key* properties.
- Once you've made these changes, run the *ensure-transactor* command, which will create the specified role, if necessary, and assign the policies required to access your DynamoDB table, S3 bucket and Cloudwatch:

``` sh
bin/datomic ensure-transactor my-transactor.properties my-transactor.properties
```

- If you are using a Datomic-generated CloudFormation to start your transactor, regenerate your CloudFormation template to use a role by running this command:

``` sh
bin/datomic create-cf-template my-transactor.properties my-cf.properties cf.json
```

- Restart your CloudFormation using the new template. It will start a transactor instance using the role you specified in your properties file.
- If you start your transactor server instance some other way, make sure it is running under the role you specified for *aws-transactor-role*, restarting it if necessary.

<a id="outline-container-migrating-peers"></a>

<a id="migrating-peers"></a>

## Migrating peers

<a id="text-migrating-peers"></a>

To migrate peers running on EC2 to use roles, do the following:

- Edit you transactor properties file.
- Add a *aws-peer-role* property. You can leave the value blank or specify the name of a role to use. If the role does not exist, it will be created for you later in this process.
- Comment out the *aws-dynamodb-peer-user*, *aws-dynamodb-peer-access-key-id* and *aws-dynamodb-peer-secret-key* properties.
- Once you've made these changes, run the *ensure-transactor* command, which will create the specified role, if necessary, and assign the policy required to access your DynamoDB table:

``` sh
bin/datomic ensure-transactor my-transactor.properties my-transactor.properties
```

- Make sure your peer server is running under the role you specified for *aws-peer-role*, restarting it if necessary.

<a id="outline-container-access-keys"></a>

<a id="access-keys"></a>

## Using IAM user access keys

<a id="text-access-keys"></a>

It is still possible to use IAM user access keys to access resources. Please see [AWS Access Control](../../../05-operation/01-pro/14-aws-access-control/aws-access-control.md) for more details.

<a id="outline-container-role-policies"></a>

<a id="role-policies"></a>

## Required role policies

<a id="text-role-policies"></a>

The specific role policies required by the transactor and peer library are documented in [Setting Up Storage Services](../../../05-operation/01-pro/01-storage-services/storage-services.md) and [Backup and Restore](../../../05-operation/01-pro/08-backup-and-restore/backup-and-restore.md). If you follow the procedures above, you do not have to configure these policies yourself. If, however, you use other tools to manage your AWS resources, then having the specific policies may be helpful.
