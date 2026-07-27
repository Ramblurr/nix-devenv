<a id="content"></a>

<a id="moving-to-cloud"></a>

# Moving to Cloud

Datomic Cloud is ideal for greenfield projects where you need:

- Quick and easy access to Datomic on AWS
- More ops ability with less responsibility

> To take the greatest advantage of AWS features, Cloud uses a storage format different from that used in Datomic Pro.
>
> We are currently designing migration tools for users who want to move from Datomic Pro to Cloud, but these tools are not part of the initial release. If, after reviewing the differences outlined below, you want to migrate from Datomic Pro to Cloud, we want to [hear from you](mailto:support@cognitect.com), and help you plan.

<a id="outline-container-similarities"></a>

<a id="similarities"></a>

## Similarities Between Cloud and Datomic Pro

<a id="text-similarities"></a>

The information model is what makes Datomic Datomic, and is entirely the same between Cloud and Datomic Pro. This includes:

- Datoms, entities, and indexes
- ACID transactions
- The universal schema
- Datalog query and structural pull
- The indelible, accumulate-only model of time
- The database as a value

<a id="outline-container-aws-integration"></a>

<a id="aws-integration"></a>

## Difference 1: AWS Integration

<a id="text-aws-integration"></a>

Datomic Cloud is tightly integrated with AWS.

This has three implications:

- Greenfield Datomic apps on AWS should target Cloud
- Datomic apps that do not run on AWS **must** target Datomic Pro
- Existing Datomic apps on AWS can be ported to the Cloud once the migration tools are available

<a id="outline-container-clients"></a>

<a id="clients"></a>

## Difference 2: Clients and Peers

<a id="text-clients"></a>

Datomic Pro supports client or peer access, while Cloud supports only client access.

This has two implications:

- Apps that target the client API are much easier to move between Datomic Pro and Cloud
- Apps that make heavy use of peer locality will require substantial alteration for Cloud

Check clients and peers for more information.

<a id="outline-container-ions"></a>

<a id="ions"></a>

## Difference 3: Ions

<a id="text-ions"></a>

Datomic lets you run your code in process with your data. In Datomic Pro, this takes the form of [functions installed in a database](../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md), or [functions you add to the classpath](../../../06-reference/02-transactions/04-transaction-functions/transaction-functions.md).

Datomic Cloud's tight AWS integration makes this capability much more powerful. [Ions](../../../07-datomic-cloud-ions/01-ions-overview/ions-overview.md) let you run your entire application on Datomic, with reproducible deployment, elastic autoscaling, and integration via AWS lambda events and AWS API gateway.

<a id="outline-container-other"></a>

<a id="other"></a>

## Other Differences

<a id="text-other"></a>

In each of the areas in the table below, we believe that the Cloud architecture can offer capabilities that will be superior to those currently in Datomic Pro:

| Datomic Pro               | Cloud (Future)                             |
|---------------------------|--------------------------------------------|
| User partition control    | Auto partitioning (now), partition routing |
| Limited search capability | CloudSearch integration                    |
| Byte array type           | LOB types                                  |

These and other differences are explained below.

<a id="outline-container-partitioning"></a>

<a id="partitioning"></a>

### Auto Partitioning

<a id="text-partitioning"></a>

The peer model supports two kinds of tempids: `#db/id` structures and strings. The client model supports only strings. This makes client drivers and client programs easier to write and use, and it eliminates partition control as a user-space concern.

<a id="outline-container-text-search"></a>

<a id="text-search"></a>

### Text Search

<a id="text-text-search"></a>

Datomic Pro provides a limited text search capability that depends on keeping two index types (Datomic and Lucene) roughly in sync, despite the fact that the two kinds of indexing have different Big O time complexity. On Cloud, we recommend using CloudSearch and are considering adding CloudSearch integration as an option in Datomic.

<a id="outline-container-symbol-magic"></a>

<a id="symbol-magic"></a>

### No Symbol Magic

<a id="text-symbol-magic"></a>

To transparently reach languages lacking a symbolic type, Datomic Pro will in some situations magically convert strings into symbolic types, e.g. ":hello" to `:hello`.

Cloud does not perform this kind of magic, and client libraries are always responsible for mapping EDN types to sensible language-local representations.

<a id="outline-container-excision"></a>

<a id="excision"></a>

### No Excision

<a id="text-excision"></a>

Cloud does not currently support *excision*.
