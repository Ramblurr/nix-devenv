<a id="content"></a>

<a id="peer-language-support"></a>

# Peer Language Support

<a id="outline-container-jvm-languages"></a>

<a id="jvm-languages"></a>

## JVM Languages

<a id="text-jvm-languages"></a>

The Datomic team supports the Java and Clojure APIs. Community supported, third-party libraries are described in the section [third-party libraries](#third-party-libraries).

<a id="outline-container-java"></a>

<a id="java"></a>

### Java

<a id="text-java"></a>

The [Java API](../../../04-apis/02-peer-api-javadoc/documentation-home/documentation-home.md) gives Java users access to all the features of the Peer library. Additionally, the [Util](../../../04-apis/02-peer-api-javadoc/classes/util/util.md) class contains convenience functions for creating and working with Datomic's commonly used data structures.

<a id="outline-container-clojure"></a>

<a id="clojure"></a>

### Clojure

<a id="text-clojure"></a>

The [Clojure API](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md) is a functional projection of the [Java API](../../../04-apis/02-peer-api-javadoc/documentation-home/documentation-home.md). The methods of the Java types are flattened to functions in a single *datomic.api* namespace with an instance of the given type as the first argument.

It is idiomatic to reference the *datomic.api* namespace as *d*, with *db* and *q* added to the current namespace.

``` clojure
(ns project-ns
  (:require [datomic.api :as d :refer [db q]]))
```

The code below illustrates the translation of the Java API to Clojure.

Here is the code in Java:

``` java
String uri = "datomic:mem://test";
Connection conn = Peer.connect(uri);
Collection results = Peer.query("[:find ?e :where [?e :db/doc]]", conn.db);
```

And the equivalent code in Clojure:

``` clojure
;; clojure
(def uri "datomic:mem://test")
(def conn (d/connect uri))
(def results (q '[:find ?e :where [?e :db/doc]] (db conn)))
```

<a id="outline-container-other-jvm"></a>

<a id="other-jvm"></a>

### Other JVM Languages (JRuby, Scala, Groovy etc.)

<a id="text-other-jvm"></a>

Users of other JVM languages can use the [Java API](../../../04-apis/02-peer-api-javadoc/documentation-home/documentation-home.md) via their respective Java interop capabilities.

<a id="outline-container-non-jvm"></a>

<a id="non-jvm"></a>

## Non-JVM Languages

<a id="text-non-jvm"></a>

Non-JVM languages can access Datomic through the REST service via HTTP.

<a id="outline-container-rest-service"></a>

<a id="rest-service"></a>

### The REST Service

<a id="text-rest-service"></a>

A Datomic peer can be run as a standalone HTTP service. See the REST service [documentation](../../../04-apis/10-rest-api/rest-api.md) for information on starting and stopping the service. Many clients can connect to a single instance of the HTTP service, and one instance of the service represents one licensed peer.

The service is its own documentation. Just point a browser at the root of the server:port on which you started the service. Note that the 'web app' that results **is** the service. It is not an app built on the service, nor a set of documentation pages about the service. The URIs, query params, and POST data are the same ones you will use when accessing the service programmatically.

In addition to the self-describing nature of the REST service, some basic documentation of the available endpoints is available in the REST service [documentation](../../../04-apis/10-rest-api/rest-api.md).

The REST service accepts and responds with EDN data.

<a id="outline-container-edn"></a>

<a id="edn"></a>

### [EDN](https://github.com/edn-format/edn)

<a id="text-edn"></a>

EDN is an extensible data notation (pronounced \[eed-n\]). For more information, see the [specification](https://github.com/edn-format/edn). Reader/writer implementations are available in various [languages](https://github.com/edn-format/edn/wiki/Implementations).

A full-featured client of the Datomic REST service should support round-trip conversions between native data structures and [EDN](https://github.com/edn-format/edn), the data format that the REST service sends and receives. Doing so would allow users of the native language to build transactions and queries using native data structures, just like users of the Peer library in JVM languages.

<a id="outline-container-third-party-libraries"></a>

<a id="third-party-libraries"></a>

## Third-Party Libraries

<a id="text-third-party-libraries"></a>

Datomic community members have contributed the following language-specific libraries which provide idiomatic support for Datomic. The Datomic team encourages third-party language libraries but does not support them directly.

- [Native JVM Peer with Scala idioms](https://dwhjames.github.io/datomisca)
- [Native (JRuby) and REST ActiveModel wrapper for Ruby](https://github.com/relevance/diametric)
- [REST client in JavaScript, for use with Node.js and similar](https://github.com/limadelic/datomicjs)
- [Native JVM Peer with Groovy idioms](https://github.com/jeffbrown/groovy-datomic)
- [REST client in Python](https://github.com/gns24/pydatomic)
- [Native JVM Peer with type-safe Scala meta-DSL](https://github.com/scalamolecule/molecule)
