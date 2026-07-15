<a id="content"></a>

<a id="integrating-the-legacy-peer-library"></a>

# Integrating the legacy Peer Library

This document describes how to integrate the [Datomic peer library](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md) with your Java or Clojure project. This section only applies to Datomic versions 1.0.6711 or lower. For current instructions using the latest Datomic versions and peer API see [Integrating the Peer Library](../../../02-accessing/01-peer-library/peer-library.md).

<a id="outline-container-maven-setup"></a>

<a id="maven-setup"></a>

## Maven Setup

<a id="text-maven-setup"></a>

There are two ways to install the Datomic libraries in your local Maven repository. You can configure your project to use the my.datomic.com maven repository or run an install script included with the Datomic distribution.

<a id="outline-container-my-datomic"></a>

<a id="my-datomic"></a>

### Datomic Maven Repository

<a id="text-my-datomic"></a>

Datomic Pro users can get the Datomic peer library directly from the Maven repository hosted at my.datomic.com.

> See the download and integration instructions by logging into your account at [https://my.datomic.com](https://my.datomic.com/).

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
mvn install:install-file -DgroupId=com.datomic -DartifactId=datomic-pro -Dfile=datomic-pro-0.9.5703.jar -DpomFile=pom.xml
```

<a id="outline-container-deps"></a>

<a id="deps"></a>

## Deps.edn

<a id="text-deps"></a>

``` clojure
com.datomic/datomic-EDITION     {:mvn/version "VERSION"}
```

<a id="outline-container-maven"></a>

<a id="maven"></a>

## Using from Maven

<a id="text-maven"></a>

1.  Replace VERSION in the snippet below with the contents of the VERSION file at the root of this distribution.
2.  Replace EDITION with either 'free' or 'pro' based on which edition. you are installing
3.  Add the modified snippet to the dependencies section of your pom.xml:

``` xml
<dependency>
  <groupId>com.datomic</groupId>
  <artifactId>datomic-EDITION</artifactId>
  <version>VERSION</version>
</dependency>
```

<a id="outline-container-leiningen"></a>

<a id="leiningen"></a>

## Using from Leiningen

<a id="text-leiningen"></a>

1.  Replace VERSION in the snippet below with the contents of the VERSION file at the root of this distribution
2.  Replace EDITION with either 'free' or 'pro' based on which edition you are installing
3.  Then add the snippet to the dependencies section of your project.clj:

``` clojure
;; in collection under :dependencies key
[com.datomic/datomic-EDITION "VERSION"]
```
