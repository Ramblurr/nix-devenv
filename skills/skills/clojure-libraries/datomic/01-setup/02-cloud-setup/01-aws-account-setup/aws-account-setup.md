<a id="content"></a>

<a id="account-setup"></a>

# Account Setup

This page covers making sure your AWS account is compatible with and correctly configured for Datomic Cloud. Once you have performed these steps, you can start any number of systems in regions that support Datomic.

- [EC2 key pair](#ec2-keypair)
- [Supported regions](#regions)

<a id="outline-container-ec2-keypair"></a>

<a id="ec2-keypair"></a>

## EC2 Key Pair

<a id="text-ec2-keypair"></a>

It is required to associate an EC2 key pair with [EC2 instances](../../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md#nodes) launched by Datomic. This keypair is never used by Datomic itself, and by default SSH ingress is disabled. The key pair is available in case an operator wants to deliberately open SSH ingress and log into boxes.

If you do not already have an EC2 Key Pair, create one from the [EC2 Key Pair console](https://console.aws.amazon.com/ec2/v2/home?#KeyPairs) by following these steps:

1.  Click the "Create key pair" button.

2.  Enter a name for your new key pair. Take note of this name – you will need it when you [start a system](../02-cloud-setup/cloud-setup.md).

3.  Press the "Create" button.

4.  Save the downloaded certificate (.pem) file for later use.

5.  From a Terminal window run:

    `chmod 400 <path-to-your-pem-file>`

    Replacing \<path-to-your-pem-file\> with the path to the .pem file you downloaded in step 4.

<a id="outline-container-regions"></a>

<a id="regions"></a>

## Supported Regions

<a id="text-regions"></a>

Datomic Cloud currently runs in the following AWS regions:

- us-east-1
- us-east-2
- us-west-2
- ca-central-1
- eu-central-1
- ap-southeast-1
- ap-southeast-2
- ap-northeast-1
- ap-south-1
- sa-east-1
- eu-west-1
- eu-west-2
- eu-north-1

If you are unfamiliar with AWS region codes, you can [review available AWS region codes here.](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html#concepts-available-regions)

If you are interested in a region not shown here, please contact [Datomic support](https://www.datomic.com/support.html).
