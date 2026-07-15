<a id="content"></a>

<a id="legacy-license-install"></a>

# Legacy License Install

As of April 27th 2023, **all editions of Datomic are free**, with binaries licensed under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0.html).

> This section only applies to [versions 1.0.6711](../../../11-releases/04-datomic-change-logs/datomic-change-logs.md) and below.

<a id="outline-container-install-license"></a>

<a id="install-license"></a>

## Install your license key

<a id="text-install-license"></a>

1.  To use a storage other than free, you will need to use a Pro license. If you do not have a license yet, you can request a [Starter License](https://my.datomic.com/starter).
2.  Once you have your key, you can install it by pasting the key into the value of the license-key property in your transactor properties file:

noslide

``` sh
license-key=XXXXXXXX...
```

You are now ready to [start the transactor](../../../03-tutorials/01-peer-tutorial/01-run-a-transactor/run-a-transactor.md).
