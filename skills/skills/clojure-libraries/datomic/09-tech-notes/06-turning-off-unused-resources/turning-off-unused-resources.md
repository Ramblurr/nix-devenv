<a id="content"></a>

<a id="turning-off-unused-compute-resources"></a>

# Turning Off Unused Compute Resources

While you can [delete a compute stack](../../05-operation/02-cloud/15-deleting/deleting.md#deleting-stacks) at any time without loss of data, it is often useful to instead temporarily turn down unused compute capacity in a Datomic system. This is achieved by setting the scaling capacity targets for your compute group's auto-scaling group to 0.

<a id="outline-container-adjusting-the-asg"></a>

<a id="adjusting-the-asg"></a>

## Adjusting the ASG

<a id="text-adjusting-the-asg"></a>

<a id="outline-container-aws-console"></a>

<a id="aws-console"></a>

### CloudFormation

<a id="text-aws-console"></a>

- Go to [CloudFormation](https://console.aws.amazon.com/cloudformation/home).
- Select the stack that you want to adjust the ASG on.
- Click "Stack actions".
- Click "Update".
- Select "Use current template".
- Click "Next".
- Make your changes in the "Auto scaling configuration" section.
  - Ensure that the other settings match your desired stack configuration.
  - "Minimum number of instances during update" should always be 1 fewer than "Maximum instances".
- Click "Next".
- Acknowledge any capabilities listed.
- Click "Update stack".

<a id="outline-container-legacy-aws-console"></a>

<a id="legacy-aws-console"></a>

### AWS Console (Legacy)

<a id="text-legacy-aws-console"></a>

Select your stack (query group or primary compute group) in the [Auto Scaling Group Console](https://console.aws.amazon.com/ec2/autoscaling/home#AutoScalingGroups:view=details) and click the "Edit" button:

[![editASG.png](../../images/editASG.png)](../../images/editASG.png)

In the dialog box that appears, set the *Desired Capacity*, *Min*, and *Max* to 0 and click "Save".

The ASG will terminate all nodes of that compute or query group without removing any of the other system resources. When you wish to re-activate your capacity, edit the same ASG and set the scaling capacity targets back to their original values.

<a id="outline-container-legacy"></a>

<a id="legacy"></a>

## Legacy

<a id="text-legacy"></a>

<a id="outline-container-cli-tools---solo-topology"></a>

<a id="cli-tools---solo-topology"></a>

### CLI Tools - Solo Topology (Legacy)

<a id="text-cli-tools---solo-topology"></a>

> This section only applies to [Datomic 781-9041](../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and lower.

The `datomic solo` CLI Tool command can be used to set the ASG to 0 or 1 for [solo topology systems](../../05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md).
