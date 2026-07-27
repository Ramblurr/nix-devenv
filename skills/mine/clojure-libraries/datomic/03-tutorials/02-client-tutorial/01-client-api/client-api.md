<a id="content"></a>

<a id="client-api-tutorial"></a>

# Client API Tutorial

This tutorial introduces the Datomic Client API. You will:

- [Create a database](#create-database)
- [Transact schema](#transact-schema)
- [Transact data](#transact-data)
- [Query the database](#query)
- Optionally [delete the database](#delete-database) when you are done

<a id="outline-container-prerequisites"></a>

<a id="prerequisites"></a>

## Prerequisites

<a id="text-prerequisites"></a>

This tutorial assumes that you have [setup Datomic Local](../../../01-setup/03-local-setup/local-setup.md) and started a REPL with Datomic Local on your classpath, or you have [launched](../../../01-setup/02-cloud-setup/02-cloud-setup/cloud-setup.md) a Datomic Cloud system and know how to start a Clojure REPL with the [Datomic client API installed](../../../02-accessing/02-client-library/client-library.md#installing).

<a id="outline-container-create-client"></a>

<a id="create-client"></a>

## Create a Client

<a id="text-create-client"></a>

<a id="outline-container-using-datomic-local"></a>

<a id="using-datomic-local"></a>

### Using Datomic Local

<a id="text-using-datomic-local"></a>

To interact with Datomic, you must first create a [datomic.client.api/client](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-client).

In your REPL, execute:

noslide

``` clojure
(require '[datomic.client.api :as d])

(def cfg {:server-type :datomic-local
          :system "datomic-samples"})

(def client (d/client cfg))
```

<a id="outline-container-using-datomic-cloud"></a>

<a id="using-datomic-cloud"></a>

### Using Datomic Cloud

<a id="text-using-datomic-cloud"></a>

To [connect](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-connect) to Datomic Cloud, you will need the following information:

- `:region` is the AWS region in which you've started Datomic Cloud.
- `:system` is your Datomic system's name.
- `:endpoint` is your system's client endpoint. Check your [CloudFormation outputs](../../../05-operation/02-cloud/11-how-to/how-to.md#template-outputs) for `ClientApiGatewayEndpoint`.

Use this information to create a client with [datomic.client.api/client](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-client).

Even though the endpoint is public, client access is securely managed by [IAM permissions](../../../05-operation/02-cloud/06-access-control/access-control.md#how-datomic-access-control-works).

noslide

``` clojure
(require '[datomic.client.api :as d])

(def cfg {:server-type :cloud
          :region "<your AWS Region>" ;; e.g. us-east-1
          :system "<system name>"
          :creds-profile "<your_aws_profile_if_not_using_the_default>"
          :endpoint "<your endpoint>"})

(def client (d/client cfg))
```

Warnings may occur. Do not be alarmed as they will not affect functionality during this tutorial.

<a id="outline-container-create-database"></a>

<a id="create-database"></a>

## Create a Database

<a id="text-create-database"></a>

- Create a new database with [datomic.client.api/create-database](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-create-database):

noslide

``` clojure
(d/create-database client {:db-name "movies"})
```

- Now you're ready to connect to your newly created database using [datomic.client.api/connect](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-connect):

noslide

``` clojure
(def conn (d/connect client {:db-name "movies"}))
```

The next step will be to define some schema for your new database.

Schema defines the set of possible attributes that can be associated with an entity. We'll need to provide 3 attributes: [db/ident](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-ident), [db/valueType](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-valuetype) and [db/cardinality](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-cardinality). [db/doc](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-doc) will also be provided for documentation.

<a id="outline-container-transact-schema"></a>

<a id="transact-schema"></a>

## Transact Schema

<a id="text-transact-schema"></a>

Now we need to create a [schema](../../../06-reference/01-schema/01-schema-reference/schema-reference.md).

- Define the following small schema for a database about movies:

noslide

``` clojure
(def movie-schema [{:db/ident :movie/title
                    :db/valueType :db.type/string
                    :db/cardinality :db.cardinality/one
                    :db/doc "The title of the movie"}

                   {:db/ident :movie/genre
                    :db/valueType :db.type/string
                    :db/cardinality :db.cardinality/one
                    :db/doc "The genre of the movie"}

                   {:db/ident :movie/release-year
                    :db/valueType :db.type/long
                    :db/cardinality :db.cardinality/one
                    :db/doc "The year the movie was released in theaters"}])
```

- Now transact the schema using [datomic.client.api/transact](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-transact).

noslide

``` clojure
(d/transact conn {:tx-data movie-schema})
```

``` clojure
=>
{:db-before ..., 
 :db-after ..., 
 :tx-data [...], ;; data added to the database
 :tempids {}}
```

You should get back [a response](../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md) as shown above.

<a id="outline-container-transact-data"></a>

<a id="transact-data"></a>

## Transact Data

<a id="text-transact-data"></a>

- Now you can define some movies to add to the database utilizing the [schema](../../../06-reference/01-schema/01-schema-reference/schema-reference.md#defining-schema) we defined earlier:

noslide

``` clojure
(def first-movies [{:movie/title "The Goonies"
                    :movie/genre "action/adventure"
                    :movie/release-year 1985}
                   {:movie/title "Commando"
                    :movie/genre "thriller/action"
                    :movie/release-year 1985}
                   {:movie/title "Repo Man"
                    :movie/genre "punk dystopia"
                    :movie/release-year 1984}])
```

- [Transact](../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md) the movies into the database:

noslide

``` clojure
(d/transact conn {:tx-data first-movies})
```

``` clojure
=>
{:db-before ... 
 :db-after ...
 :tx-data [...], 
 :tempids {}}
```

You should see a response similar to the above with different data.

<a id="outline-container-query"></a>

<a id="query"></a>

## Query

<a id="text-query"></a>

- Get a current value for the database with [datomic.client.api/db](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-db):

noslide

``` clojure
(def db (d/db conn))  
```

- Now create a [query](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md) for all movie titles:

noslide

``` clojure
(def all-titles-q '[:find ?movie-title 
                    :where [_ :movie/title ?movie-title]])
```

- And execute the query with the value of the database using [datomic.client.api/q](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-q):

noslide

``` clojure
(d/q all-titles-q db)
```

``` clojure
=>
[["Commando"] ["The Goonies"] ["Repo Man"]]
```

If your database has a large number of movies, it may be prudent to use [qseq](../../../06-reference/03-query-and-pull/01-executing-queries/executing-queries.md#qseq) to return a lazy sequence quickly rather than waiting for the full results to build and return.

<a id="outline-container-delete-database"></a>

<a id="delete-database"></a>

## Delete a Database (Optional)

<a id="text-delete-database"></a>

When you are done with this tutorial, you can use [datomic.client.api/delete-database](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-delete-database) to delete the *movies* database:

noslide

``` clojure
(d/delete-database client {:db-name "movies"})
```
