<a id="content"></a>

<a id="client-getting-started"></a>

# Client Getting Started

Getting started with the [client library](../../../02-accessing/02-client-library/client-library.md) is similar to [getting started with peer](../../../03-tutorials/01-peer-tutorial/02-connect-to-a-database/connect-to-a-database.md) except for a few differences:

- [Dev setup](#local-dev-setup)
- [Integrate the client library](#installing)
- [Connecting to a database](#connect-to-a-database)
- [Transacting](#transacting)

Once you have your [development environment](#local-dev-setup) setup and have [connected to a database](#connect-to-a-database), follow the instructions on this page.

<a id="outline-container-installing"></a>

<a id="installing"></a>

## Installing the Client Library

<a id="text-installing"></a>

The Datomic client library includes both the [synchronous](../../../04-apis/04-client-api/client-api.md#sync) and [asynchronous](../../../04-apis/04-client-api/client-api.md#async) APIs, and is provided via [Maven central](http://search.maven.org/#search%7Cga%7C1%7Ca%3A%22client-pro%22).

<a id="outline-container-deps"></a>

<a id="deps"></a>

### Clojure CLI

<a id="text-deps"></a>

To use the Client library from a [Clojure CLI REPL](../../02-cloud/11-how-to/how-to.md#clojure-cli), add the following to your [deps.edn](https://clojure.org/guides/deps_and_cli) dependencies map:

``` clojure
com.datomic/client-pro {:mvn/version "1.0.81"}
```

<a id="outline-container-maven"></a>

<a id="maven"></a>

### Maven

<a id="text-maven"></a>

To retrieve the Client library for a Maven project, add the following snippet inside the `<dependencies>` block of your pom.xml file:

``` xml
<dependency>
 <groupId>com.datomic</groupId>
 <artifactId>client-pro</artifactId>
 <version>1.0.81</version>
</dependency>
```

<a id="outline-container-leiningen"></a>

<a id="leiningen"></a>

### Leiningen

<a id="text-leiningen"></a>

To include the client library in a Leiningen project, add the following snippet to your [project.clj](https://github.com/technomancy/leiningen#configuration) file in the collection under the `:dependencies` key.

``` clojure
com.datomic/client-pro {:mvn/version "1.0.81"}
```

Make sure that Clojure dependency is set to at least `[org.clojure/clojure "1.9.0"]`.

<a id="outline-container-local-dev-setup"></a>

<a id="local-dev-setup"></a>

## Local Development Setup

<a id="text-local-dev-setup"></a>

The Datomic *peer server* provides an interface for Datomic [clients](#repl) to access databases. The peer server communicates with storage and the transactor to service both reads from and writes to Datomic databases.

> The tutorial uses the `mem` storage option with the peer server. A transactor does not need to be running when using `mem`, but a transactor must be running and connected to the storage when using other storage.

Navigate to the root of your Datomic distribution directory, then run:

``` sh
bin/run -m datomic.peer-server -h localhost -p 8998 -a myaccesskey,mysecret -d hello,datomic:mem://hello
```

This starts a peer server with:

| Flag | Name | Value | Description |
|----|----|----|----|
| `-h` | Host | `localhost` | The hostname |
| `-p` | Port | `8998` | The port to listen on |
| `-a` | Access key | `myaccesskey` | An access key (you will this pass back to the peer server later to authenticate yourself) |
| `-a` | Secret | `mysecret` | A secret (you will this pass back to the peer server later to authenticate yourself) |
| `-d` | storage | `hello` | A URL describing what storage to use and a database name |

The tutorial will use the `mem` storage. `mem` stores the data in memory and does not persist beyond the life of the process.

More details on configuration and options are on the [peer server](../16-peer-server/peer-server.md) documentation page.

The peer server process will lock the terminal to this peer server process until the process is killed. CTRL-C will kill the process, or you can close the terminal window.

> Continuing with the tutorial with the client will require a running peer server.

<a id="outline-container-repl"></a>

<a id="repl"></a>

### Integrate Client Library

<a id="text-repl"></a>

The client library must be integrated into your project. [Follow the instructions for your preferred project type](../../../02-accessing/02-client-library/client-library.md).

Follow the instructions until you have a running REPL.

<a id="outline-container-connect-to-a-database"></a>

<a id="connect-to-a-database"></a>

## Connect to a Database

<a id="text-connect-to-a-database"></a>

The Datomic *client library* communicates with a *peer server*. If you have not yet started a peer server, follow the [local development setup](#local-dev-setup) section prior to attempt to connect a Datomic client.

The first step to interacting with Datomic via the client API is creating a client with [`datomic.client.api/client`](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-connect).

Then create a connection with [`datomic.client.api/connect`](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-connect) by passing in the client and a database name.

Creating a client requires several important parameters:

- `:endpoint` is the host and port where Datomic is running and listening.
- `:secret` and `:access-key` are two opaque strings that match similar tokens provided when launching Datomic. They are set to "mysecret" and "myaccesskey" in this tutorial.

[`datomic.client.api/client`](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-connect) takes a map with your client configuration.

``` clojure
(def cfg {:server-type :peer-server
          :access-key "myaccesskey"
          :secret "mysecret"
          :endpoint "localhost:8998"
          :validate-hostnames false})
```

``` clojure
=> #'user/cfg
```

Create a client:

``` clojure
(def client (d/client cfg))
```

``` clojure
=> #'user/client
```

Create a connection with that client:

``` clojure
(def conn (d/connect client {:db-name "hello"}))
```

``` clojure
=> #'user/conn
```

A var called "`conn`" was created, which is holding your database connection. You can inspect it:

``` clojure
conn
```

``` clojure
=> {:db-name "hello", 
    :database-id "5a381758-6e47-4504-aa08-07067b5c241a", 
    :t 1008, 
    :next-t 1009, 
    :type :datomic.client/conn}
```

This tells you that you have an available connection to the database called "hello" as well as a few other details which you will learn more about later. You can now use "conn" as an input to future commands.

<a id="outline-container-transacting"></a>

<a id="transacting"></a>

## Transacting

<a id="text-transacting"></a>

The *client library's* `transact` function takes the transaction data in a map under the key `:tx-data`.

> `movie-schema` is defined in the peer [transacting schema](../../../03-tutorials/01-peer-tutorial/03-transact-schema/transact-schema.md) section. Follow that guide, starting from that section with these modifications to learn about using *client*.

``` clojure
(d/transact conn {:tx-data movie-schema})
```

``` clojure
=>
{:db-before {:database-id "58a47389-f1ab-4d81-85b6-715cecde9bac", 
             :t 63, 
             :next-t 1000, 
             :history false}, 
 :db-after {:database-id "58a47389-f1ab-4d81-85b6-715cecde9bac", 
            :t 1000, 
            :next-t 1001, 
            :history false}, 
 :tx-data [ #datom[13194139534312 50 #inst "2017-02-15T15:28:31.174-00:00" 13194139534312 true] 
            #datom[63 10 :movie/title 13194139534312 true] 
            #datom[63 40 23 13194139534312 true] 
            #datom[63 41 35 13194139534312 true] 
            #datom[63 62 "The title of the movie" 13194139534312 true] 
            #datom[64 10 :movie/genre 13194139534312 true] 
            #datom[64 40 23 13194139534312 true] 
            #datom[64 41 35 13194139534312 true] 
            #datom[64 62 "The genre of the movie" 13194139534312 true] 
            #datom[65 10 :movie/release-year 13194139534312 true] 
            #datom[65 40 22 13194139534312 true] 
            #datom[65 41 35 13194139534312 true] 
            #datom[65 62 "The year the movie was released in theaters" 13194139534312 true] 
            #datom[0 13 65 13194139534312 true] 
            #datom[0 13 64 13194139534312 true] 
            #datom[0 13 63 13194139534312 true]], 
 :tempids {-9223301668109598144 63, -9223301668109598143 64, -9223301668109598142 65}}
```

This is in contrast to the [peer](../../../03-tutorials/01-peer-tutorial/03-transact-schema/transact-schema.md) library. [Peer's `transact`](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/transact) takes the tx-data directly and returns a future which must be clojure.core/derefed.

The rest of the [getting started](../../../03-tutorials/01-peer-tutorial/03-transact-schema/transact-schema.md) guide applies to the client library with this difference in mind.
