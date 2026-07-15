<a id="content"></a>

<a id="accessing-the-peer-library"></a>

# Accessing the Peer Library

This page is for users who have completed the [Datomic Pro setup](../../01-setup/01-pro-setup/pro-setup.md) and covers integrating the [Datomic peer library](../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md) into your Java or Clojure project.

The [peer library](../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md) must be on the classpath to be used to interact with Datomic.

- [Maven setup](#maven-setup)
- [Using from Deps.edn](#deps)
- [Using from Maven](#maven)
- [Using from Leiningen](#leiningen)

<a id="outline-container-maven-setup"></a>

<a id="maven-setup"></a>

## Maven Setup

<a id="text-maven-setup"></a>

There are two ways to install the Datomic libraries in your local Maven repository. You can configure your project to use the com.datomic Maven repository or run an install script included with the Datomic distribution.

<a id="outline-container-deps"></a>

<a id="deps"></a>

## Using From Deps.edn

<a id="text-deps"></a>

To include the Datomic peer library in your `deps.edn` project, declare the following dependency in `:deps`:

``` clojure
com.datomic/peer {:mvn/version "1.0.7622"}
```

<a id="outline-container-maven"></a>

<a id="maven"></a>

## Using From Maven

<a id="text-maven"></a>

To include the Datomic peer library in a Maven-based build, add the modified snippet to the dependencies section of your pom.xml:

``` xml
<dependency>
  <groupId>com.datomic</groupId>
  <artifactId>peer</artifactId>
  <version>1.0.7622</version>
</dependency>
```

<a id="outline-container-leiningen"></a>

<a id="leiningen"></a>

## Using from Leiningen

<a id="text-leiningen"></a>

To include the Datomic peer library in a leiningen project, add the snippet to the dependencies section of your project.clj:

``` clojure
;; in collection under :dependencies key
[com.datomic/peer "1.0.7622"]
```

<a id="outline-container-local-maven-repository"></a>

<a id="local-maven-repository"></a>

### Installing from Datomic Distribution

<a id="text-local-maven-repository"></a>

You can install the Datomic peer library in your local Maven repository by running the following command from the Datomic distribution's root directory:

``` sh
bin/maven-install
```

Or on [Windows](https://maven.apache.org/guides/getting-started/windows-prerequisites.html):

``` sh
mvn install:install-file -DgroupId=com.datomic -DartifactId=datomic-pro -Dfile=datomic-peer-0.9.5703.jar -DpomFile=pom.xml
```

<a id="next-steps"></a>

## Next Steps

You now have access to the Datomic peer API!

Now that you have the Datomic peer library integrated into your project, you can start the [peer tutorial](../../03-tutorials/01-peer-tutorial/peer-tutorial.md).
