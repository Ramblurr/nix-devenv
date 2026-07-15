<a id="content"></a>

<a id="setup"></a>

# Setup

<a id="outline-container-clone-the-sample-project"></a>

<a id="clone-the-sample-project"></a>

## Clone the Sample Project

<a id="text-clone-the-sample-project"></a>

``` sh
git clone https://github.com/Datomic/ion-starter.git
```

The [ion-starter](https://github.com/Datomic/ion-starter) project contains a complete ion-based application. To begin the tutorial, clone the ion-starter project.

<a id="outline-container-set-application-name"></a>

<a id="set-application-name"></a>

## Set the Application Name

<a id="text-set-application-name"></a>

Ions are deployed with an [application name](../02-ions-reference/ions-reference.md#application-name) that must match your compute group.

Edit the `resources/datomic/ion-config.edn` file and set the `:app-name` to your application name.

> Multiple compute groups can share the application name. The compute groups that you can deploy to, for that application, are displayed after a successful [push operation](../06-push-and-deploy/push-and-deploy.md#push).

<a id="outline-container-install-the-ion-dev-tools"></a>

<a id="install-the-ion-dev-tools"></a>

## Install the Ion-Dev Tools

<a id="text-install-the-ion-dev-tools"></a>

Make sure you have [installed the ion-dev tools](../../05-operation/02-cloud/11-how-to/how-to.md#ion-dev) before [deploying](../06-push-and-deploy/push-and-deploy.md), learn to [develop at the REPL](../05-develop-at-the-repl/develop-at-the-repl.md).
