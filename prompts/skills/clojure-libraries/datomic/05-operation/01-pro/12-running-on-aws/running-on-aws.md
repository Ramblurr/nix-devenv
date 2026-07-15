<a id="content"></a>

<a id="running-on-aws"></a>

# Running on AWS

> Effective 12/18/2023, the Datomic team deprecated the tooling `ensure-cft, create-cf-stack, and delete-cf-stack`, if you are creating a new system and want automation for running on AWS, use Datomic Cloud. If you are running Pro, you can create your own AWS automation. We recommend creating your own Datomic AMI (Amazon Machine Image) and AWS CloudFormation Template. For any queries or further assistance, please reach out to us through [the support portal](https://support.cognitect.com/hc/en-us/requests/new).

This document explains how to launch your transactor on AWS. Before you read this, read through [Setting Up Storage Services](../01-storage-services/storage-services.md), configure your Storage Service, and test it with a transactor running locally. When you know your transactor and storage service are working, follow the steps below to launch your transactor on AWS.

There is a [video](https://www.youtube.com/watch?v=wG5grJP3jKY) showing how to launch Datomic on AWS.

All of the script commands described in this document must be executed from the root directory of the Datomic distribution.

<a id="outline-container-starting-transactor"></a>

<a id="starting-transactor"></a>

## Starting the Transactor on AWS

<a id="text-starting-transactor"></a>

You can deploy a transactor on AWS by using [CloudFormation](https://aws.amazon.com/cloudformation/) to launch a Datomic AMI on an EC2 instance size of your choice. This section describes the process.

A CloudFormation properties file specifies the security group, ingress rules, instance size, and which version of the transactor to run. The AMI pulls transactor bits from S3; it will use the VERSION from the Datomic distribution automatically if not otherwise specified.

<a id="outline-container-create-cloudformation-template"></a>

<a id="create-cloudformation-template"></a>

#### Create the CloudFormation template

<a id="text-create-cloudformation-template"></a>

Follow these steps to create a Cloud Formation template:

- Copy the *config/samples/cf-template.properties* file to another location and change the name to, for instance, *my-cf.properties*. Edit the copied file as desired, and check it into source control.

> Note that, by default, the CloudFormation properties only allow you to access the transactor from other EC2 machines.

You can enable access from anywhere if desired, simply uncomment the line:

```
aws-ingress-cidrs=0.0.0.0/0
```

Communication with the transactor is protected with a randomly generated username/password that are communicated to peers via the Storage Service (access to which is secured).

You can modify this setting later, but it is easier to do it now!

- Export your AWS account's credentials as environment variables so that they're accessible to scripts:

``` sh
export AWS_ACCESS_KEY_ID=<aws-access-key-id>
```

``` sh
export AWS_SECRET_ACCESS_KEY=<aws-secret-access-key>
```

- Run the *ensure-cf* command, specifying your properties file as the input and another file name as the output (the file names can be the same):

``` sh
bin/datomic ensure-cf my-cf.properties my-cf.properties
```

The *ensure-cf* command will create the necessary AWS constructs, and emit an updated properties file containing information about what it created. If errors are reported, fix them, then repeat the process.

- Run the *create-cf-template* command, specifying both your transactor properties file and your CloudFormation properties file as input, and redirect the output to a JSON file:

``` sh
bin/datomic create-cf-template my-transactor.properties my-cf.properties cf-template.json
```

<a id="outline-container-start-the-cloudformation"></a>

<a id="start-the-cloudformation"></a>

#### Start the CloudFormation Stack on AWS

<a id="text-start-the-cloudformation"></a>

Use the *create-cf-stack* command to run the configuration you have defined on AWS, passing the name of the stack and the template you previously created:

``` sh
bin/datomic create-cf-stack us-east-1 MyTransactor cf-template.json
```

That's it! In a few minutes, you will have a transactor running on AWS. You can monitor the status of the stack you created via the [AWS CloudFormation Console](https://console.aws.amazon.com/cloudformation/).

You can now run EC2-based peer applications against the transactor AMI.

Use the *delete-cf-stack* command to tear down the stack and stop all associated running instances with cf-delete-stack:

``` sh
bin/datomic delete-cf-stack us-east-1 MyTransactor
```

<a id="outline-container-connecting-transactor-aws"></a>

<a id="connecting-transactor-aws"></a>

#### Connecting to the Transactor on AWS

<a id="text-connecting-transactor-aws"></a>

If you've enabled access to your transactor from anywhere, then, after your CloudFormation stack launches, you can connect to it as described in [setting up storage services](../01-storage-services/storage-services.md). If you do not enable access, you can only connect to it from another EC2 instance in the same security group.

<a id="outline-container-aws-management-console"></a>

<a id="aws-management-console"></a>

## Using the AWS Management Console

<a id="text-aws-management-console"></a>

Once you are up and running on AWS with CloudFormation, you may want to make changes to your configuration. While you could shut down your stack, make a new configuration, and restart, it's easier to modify settings using the AWS Management Console.

- To create, update, or delete your CloudFormation stack go to the [CloudFormation console](https://console.aws.amazon.com/cloudformation/home)
- To enable or disable Internet-based access to your transactor:
  - Go to [EC2 security groups](https://console.aws.amazon.com/ec2/home?s=SecurityGroups)
  - Select your group
  - Select the *Inbound* tab in the property pane at the bottom of the right-hand window
  - Add or remove access to TCP port 4334 from "0.0.0.0/0" as needed to enable or disable Internet-based access
- To adjust the throughput on your DynamoDB table:
  - Go to the [DynamoDB console](https://console.aws.amazon.com/dynamodb/home)
  - Select your table
  - Click the *Modify Throughput* button on the toolbar
- To see CloudWatch metrics:
  - Go to the [CloudWatch console](https://console.aws.amazon.com/cloudwatch/home)
  - Select DynamoDB or EC2 metrics
  - Select desired metrics for your table or transactor instance
- To see your transactor's logs:
  - Go to the [S3 console](https://console.aws.amazon.com/s3/home)
  - Select your log bucket (see the transactor properties file output by the *bin/datomic ensure-transactor* command, it contains the bucket name)
  - Drill down in the directory hierarchy to find .zip'd log files

<a id="outline-container-s3-log-storage"></a>

<a id="s3-log-storage"></a>

## Using S3 Log Storage and CloudWatch Metrics

<a id="text-s3-log-storage"></a>

The transactor can copy its logs to [S3](https://aws.amazon.com/s3/) and publish metrics to Amazon's [CloudWatch](https://aws.amazon.com/cloudwatch/) service. These features are available even if you are not using DynamoDB as your storage service.

<a id="outline-container-s3-and-cloudwatch"></a>

<a id="s3-and-cloudwatch"></a>

#### Using S3 Log Storage and Cloudwatch Metrics with DynamodDB Storage

<a id="text-s3-and-cloudwatch"></a>

To enable log copying, uncomment this line in your transactor properties file:

```
#aws-s3-log-bucket-id=
```

If you leave the values blank, an S3 bucket will be created for you. Alternatively, you can specify an existing bucket. The IAM role specified by the *aws-transactor-role* property will be assigned a policy granting write access to the bucket.

To enable CloudWatch metrics, uncomment these lines in your transactor properties file:

```
#aws-cloudwatch-dimension-value=your-system=name
#aws-cloudwatch-region=
```

Specify a unique name for *aws-cloudwatch-dimension-value* and the desired AWS region for *aws-cloudwatch-region*. The IAM role specified by the *aws-transactor-role* property will be assigned a policy granting write access to CloudWatch.

Once your property file is edited, run the *ensure-transactor* command, specifying your properties file and another filename as the output (the file names can be the same).

``` sh
bin/datomic ensure-transactor my-transactor.properties my-transactor.properties.
```

The *ensure-transactor* command will create the necessary AWS constructs, and emit an updated properties file containing information about what it created. If errors are reported, fix them, then repeat the process. Check the final file into source control.

Start your transactor with the properties file output by the *ensure-transactor* command and one or both features will be enabled.

<a id="outline-container-other-storages"></a>

<a id="other-storages"></a>

#### Using S3 Log Storage and Cloudwatch Metrics with Other Storage

<a id="text-other-storages"></a>

To enable log copying, uncomment this line in your transactor properties file:

```
#aws-s3-log-bucket-id=
```

Set its value to the name of an existing S3 bucket.

To enable CloudWatch metrics, uncomment these lines in your transactor properties file:

```
#aws-cloudwatch-dimension-value=your-system=name
#aws-cloudwatch-region=
```

Specify a unique name for *aws-cloudwatch-dimension-value* and the desired AWS region for *aws-cloudwatch-region*.

To enable the transactor to access the AWS resources you specify, you must attach the following policies to the transactor role:

```
{"Statement":
 [{"Effect":"Allow",
   "Action":["s3:PutObject"],
   "Resource":
   ["arn:aws:s3:::{bucket-name}", "arn:aws:s3:::{bucket-name}/*"]}]}
```

```
{"Statement":
 [{"Resource":"*",
   "Effect":"Allow",
   "Action":
   ["cloudwatch:PutMetricData"],
   "Condition":{"Bool":{"aws:SecureTransport":"true"}}}]}
```

<a id="outline-container-troubleshooting"></a>

<a id="troubleshooting"></a>

## Troubleshooting the Transactor AMI

<a id="text-troubleshooting"></a>

The transactor AMI is designed as an expendable, commodity resource. It should be used once, and fail fast and shut down in the face of any unrecoverable error.

If you believe that the transactor is in a damaged state, shut it down and let CloudFormation start a new one. Never restart a transactor that is in a bad state, as you may propagate (and worsen) the problem.

<a id="outline-container-understanding-ensure-commands"></a>

<a id="understanding-ensure-commands"></a>

## Understanding "Ensure" Commands

<a id="text-understanding-ensure-commands"></a>

Some Datomic command names start with "ensure", e.g. "ensure-transactor" and "ensure-cf". Ensure commands work as follows:

- Take at least two property file arguments: input and output
- Attempt to save a valid, complete properties file in output
- Can apply defaults and provision new objects
- Report anything short of "ready to go" as errors on the console

Ensure commands are idempotent. Calling an ensure command on a complete, valid properties file is a no-op and will produce an output file identical to the input file.
