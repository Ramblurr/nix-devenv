<a id="content"></a>

<a id="local-dev-setup"></a>

# Local dev setup

Datomic is a [distributed system](../../../05-operation/01-pro/04-datomic-deployment/datomic-deployment.md). Storage services, transactors, peers, peer servers, and clients are designed so that load on one process has minimal impact on other processes (while delivering on Datomic's semantic promises).

As a convenience for development, you can 'undistribute' Datomic by running more than one process on the same virtual or physical hardware, running storage, transactor, and peer on a developer laptop.

Please note that **'development mode' cannot deliver the reliability or performance of a production deployment**, since it takes place on a single machine. Processes are competing for a single resource, and that single resource is a single point of failure. A single-machine failure brings all processes down.

> This "Getting Started" guide uses the [Peer library](../../../introduction.md). The setup process for [using the Client library and Peer Servers](../../../05-operation/01-pro/17-pro-client-getting-started/pro-client-getting-started.md) is different.

The steps for running a local 'development mode' of Datomic, using the [Peer library](../../../introduction.md) include:

- [Running a Transactor using the dev storage protocol](../../01-peer-tutorial/01-run-a-transactor/run-a-transactor.md#run-dev-transactor)
- [Integrate the Peer library in your project](../../../02-accessing/01-peer-library/peer-library.md)

> All steps in this process assume you're running commands from the root of the unzipped Datomic distribution.

<a id="outline-container-introduction"></a>

<a id="introduction"></a>

## Introduction

<a id="text-introduction"></a>

Throughout this tutorial, shell commands are run from the root directory of the Datomic distribution. This will be the version-qualified directory name. For example:

```
cd /home/user/datomic/datomic-pro-1.0.7622
```

The **bin** directory contains executable scripts for launching a REPL, installing the peer library locally, running a transactor, etc. It also contains storage configuration scripts.

For this example, we will use a local in-memory database, which does not require a transactor to run. For steps on running a transactor please see [Running a dev transactor](../../01-peer-tutorial/01-run-a-transactor/run-a-transactor.md#run-dev-transactor).

<a id="outline-container-storage"></a>

<a id="storage"></a>

## Storage

<a id="text-storage"></a>

This guide can be followed by using a local in-memory database, or with your data persisted to local storage.

The in-memory (`mem`) database does not require any special configuration, only a db-uri of `datomic:mem://<db-name>`. The rest of the tutorial assumes that you will be using `mem` storage unless you wish to run a transactor with `dev` storage to persist your changes to disk.

<a id="outline-container-integrating-peer-lib"></a>

<a id="integrating-peer-lib"></a>

## Integrating peer library

<a id="text-integrating-peer-lib"></a>

The [Peer library](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md) must be on the classpath to be used to interact with Datomic.

Follow [the instructions](../../../02-accessing/01-peer-library/peer-library.md) to set up your project *or* run your REPL with the included script in your Datomic Pro distribution.

<a id="outline-container-next-steps"></a>

<a id="next-steps"></a>

## Next steps

<a id="text-next-steps"></a>

Now that you have configured a project to use Datomic you can choose your storage:

- [Run a transactor and use `dev` storage](../../01-peer-tutorial/01-run-a-transactor/run-a-transactor.md) or
- Continue the tutorial using `mem` storage
