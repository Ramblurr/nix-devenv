<a id="content"></a>

<a id="configuring-logging"></a>

# Configuring Logging

<a id="outline-container-transactor-logging"></a>

<a id="transactor-logging"></a>

## Transactor Logging

<a id="text-transactor-logging"></a>

The Datomic transactor logs via [logback](http://logback.qos.ch/). Datomic includes a sample [logback configuration](https://logback.qos.ch/manual/configuration.html) file suitable for development at `bin/logback.xml`. This sample logback configuration is set up by default to log to the directory specified by the *log-dir* transactor property (defaults to `log/` within Datomic distribution).

Logback is open source and highly configurable. It includes built-in [appenders](https://logback.qos.ch/manual/appenders.html) that can send logs via email or to a SQL database, and you can write a custom appender for arbitrary integrations.

<a id="outline-container-txtor-s3-log-rotation"></a>

<a id="txtor-s3-log-rotation"></a>

## Transactor S3 Log Rotation

<a id="text-txtor-s3-log-rotation"></a>

The transactor can automatically migrate its logs to S3. When you set the transactor property *aws-s3-log-bucket-id*, the transactor will copy log files found in the directory configured by setting the transactor property *log-dir*. If you need more flexible access to logs, you should configure or implement a logback appender.

<a id="outline-container-peer-logging"></a>

<a id="peer-logging"></a>

## Peer Logging

<a id="text-peer-logging"></a>

The Datomic peer library uses [slf4j](http://www.slf4j.org/) for logging, so Peers can be configured to output logs via a variety of standard Java logging libraries, including *logback*, *java.util.logging* and *log4j* by:

- Including the appropriate *slf4j* JAR on the classpath
- (Optionally) adding corresponding configuration files

The following sections show how to configure Peer logging in Maven and Leiningen. If you do not configure logging for your project, the Datomic peer library will not log.

<a id="outline-container-logback"></a>

<a id="logback"></a>

### Peer Logging with *logback*

<a id="text-logback"></a>

If you choose to use logback on the peer, you can use the transactor's *bin/logback.xml* file as a starting point for your configuration.

<a id="outline-container-maven-logback"></a>

<a id="maven-logback"></a>

#### Maven

<a id="text-maven-logback"></a>

For Maven, add the following to the dependencies section of your pom.xml, replacing DATOMIC_VERSION, as described above.

``` xml
<dependency>
  <groupId>com.datomic</groupId>
  <artifactId>peer</artifactId>
  <version>DATOMIC_VERSION</version>
  <exclusions>
    <exclusion>
      <groupId>org.slf4j</groupId>
      <artifactId>slf4j-log4j12</artifactId>
    </exclusion>
    <exclusion>
     <groupId>org.slf4j</groupId>
     <artifactId>slf4j-nop</artifactId>
    </exclusion>
  </exclusions>
</dependency>
<dependency>
  <groupId>ch.qos.logback</groupId>
  <artifactId>logback-classic</artifactId>
  <version>1.4.14</version>
</dependency>
```

<a id="outline-container-leiningen-logback"></a>

<a id="leiningen-logback"></a>

#### Leiningen

<a id="text-leiningen-logback"></a>

For leiningen, add the following to the dependencies section of your project.clj, replacing DATOMIC_VERSION, as described above.

``` clojure
[com.datomic/peer "DATOMIC_VERSION"
 :exclusions [org.slf4j/slf4j-nop org.slf4j/slf4j-log4j12]]
[ch.qos.logback/logback-classic "1.4.14"]
```

<a id="outline-container-java-util-logging"></a>

<a id="java-util-logging"></a>

### Peer Logging with *java.util.logging*

<a id="text-java-util-logging"></a>

<a id="outline-container-maven-java-util-logging"></a>

<a id="maven-java-util-logging"></a>

#### Maven

<a id="text-maven-java-util-logging"></a>

For Maven, add the following to the dependencies section of your pom.xml, replacing DATOMIC_VERSION, as described above.

``` xml
<dependency>
  <groupId>com.datomic</groupId>
  <artifactId>peer</artifactId>
  <version>DATOMIC_VERSION</version>
  <exclusions>
    <exclusion>
      <groupId>org.slf4j</groupId>
      <artifactId>jul-to-slf4j</artifactId>
    </exclusion>
    <exclusion>
     <groupId>org.slf4j</groupId>
     <artifactId>slf4j-nop</artifactId>
    </exclusion>
  <exclusions>
</dependency>
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-jdk14</artifactId>
  <version>1.7.36</version>
</dependency>
```

<a id="outline-container-leiningen-java-util-logging"></a>

<a id="leiningen-java-util-logging"></a>

#### Leiningen

<a id="text-leiningen-java-util-logging"></a>

For leiningen, add the following to the dependencies section of your project.clj, replacing DATOMIC_VERSION, as described above.

``` clojure
[com.datomic/peer "DATOMIC_VERSION"
 :exclusions [org.slf4j/jul-to-slf4j org.slf4j/slf4j-nop]]
[org.slf4j/slf4j-jdk14 "1.7.36"]
```

<a id="outline-container-log4j"></a>

<a id="log4j"></a>

### Peer Logging with *log4j*

<a id="text-log4j"></a>

<a id="outline-container-maven-log4j"></a>

<a id="maven-log4j"></a>

#### Maven

<a id="text-maven-log4j"></a>

For Maven, add the following to the dependencies section of your pom.xml, replacing DATOMIC_VERSION, as described above.

``` xml
<dependency>
  <groupId>com.datomic</groupId>
  <artifactId>peer</artifactId>
  <version>DATOMIC_VERSION</version>
  <exclusions>
    <exclusion>
     <groupId>org.slf4j</groupId>
     <artifactId>slf4j-nop</artifactId>
    </exclusion>
    <exclusion>
     <groupId>org.slf4j</groupId>
     <artifactId>log4j-over-slf4j</artifactId>
    </exclusion>
  </exclusions>
</dependency>
<dependency>
  <groupId>org.slf4j</groupId>
  <artifactId>slf4j-log4j12</artifactId>
  <version>1.7.36</version>
</dependency>
```

<a id="outline-container-leiningen-log4j"></a>

<a id="leiningen-log4j"></a>

#### Leiningen

<a id="text-leiningen-log4j"></a>

For Leiningen, add the following to the dependencies section of your project.clj, replacing DATOMIC_VERSION, as described above.

``` clojure
[com.datomic/peer "DATOMIC_VERSION"
 :exclusions [org.slf4j/slf4j-nop org.slf4j/log4j-over-slf4j]]
[org.slf4j/slf4j-log4j12 "1.7.36"]
```
