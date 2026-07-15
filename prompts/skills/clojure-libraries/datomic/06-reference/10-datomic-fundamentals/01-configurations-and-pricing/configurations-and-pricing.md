<a id="content"></a>

<a id="configurations-and-pricing"></a>

# Configurations and Pricing

> This section only applies to [Datomic 990-9202](../../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and lower. Newer versions of Datomic Cloud are free of licensing related costs and not on AWS marketplace, and you will only pay for the hardware that you use to run the system.

When you start a Datomic system, you will make two choices that determine the capacity and base price of your system:

- the compute instance type
- the cluster size (number of compute instances)

The table below shows the impact of the these choices. The columns show instance size, and the rows show the capacity of each instance, as well as the monthly [base price](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md#understanding-bill) of running each instance type at a cluster size of one or two instances.

|   | Datomic local\* | t3.small | t3.medium | t3.large | t3.xlarge | t3.2xlarge |
|----|----|----|----|----|----|----|
| (v)CPUs | any | 2 | 2 | 2 | 4 | 8 |
| GB RAM | any | 2 | 4 | 8 | 16 | 32 |
| default metrics | n/a | none | basic | detailed | detailed | detailed |
| 1 instance on-demand | \$0 | \$34 | \$74 | \$127 | \$216 | \$395 |
| 2 instances on-demand | n/a | \$49 | \$118 | \$216 | \$396 | \$754 |
| 1 instance reserved | n/a | \$28 | \$62 | \$104 | \$172 | \$306 |
| 2 instances reserved | n/a | \$37 | \$96 | \$172 | \$307 | \$576 |

- The Datomic local column is included in the table as a reminder that you can develop and test Datomic applications at no cost using [dev-local](../../../01-setup/03-local-setup/local-setup.md).
- Two instances are necessary only if you require high availability.
- AWS EC2 instance pricing is on-demand by default. You can switch to EC2 reserved capacity at any time (before or after starting Datomic).
- If you are uncertain how much capacity you need, start with the defaults. You can change the instance type or cluster size at any time later as your needs change.

The table above summarizes all you need to know to [start your first system](../../../05-operation/02-cloud/02-start-a-system/start-a-system.md). For more details, and a number of more advanced options, see [growing your system](../../../05-operation/02-cloud/03-growing-your-system/growing-your-system.md).
