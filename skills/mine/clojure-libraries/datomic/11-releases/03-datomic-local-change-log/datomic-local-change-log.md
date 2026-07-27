<a id="content"></a>

<a id="datomic-local-change-log"></a>

# Datomic Local Change Log

<a id="outline-container-change-log"></a>

<a id="change-log"></a>

## Change Log

<a id="text-change-log"></a>

<a id="outline-container-291"></a>

<a id="291"></a>

### 2025/03/19 - 1.0.291

<a id="text-291"></a>

- Fix: ‘:db-name’ key is now available for Datomic Local DBs.
- Fix: changes to [BigDecimal](../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-valuetype) attribute scale no longer ignored.

<a id="outline-container-285"></a>

<a id="285"></a>

### 2024/07/11 - 1.0.285

<a id="text-285"></a>

- Upgraded com.datomic/client-api to 1.0.69
- Fix: datomic.client.api.async/client now accepts :datomic-local as a :server-type

<a id="outline-container-277"></a>

<a id="277"></a>

### 2024/02/12 - 1.0.277

<a id="text-277"></a>

Fix: correctly deserialize URIs to java.net.URI.

<a id="outline-container-276"></a>

<a id="276"></a>

### 2023/12/20 - 1.0.276

<a id="text-276"></a>

- Fix: regression introduced in 1.0.267 that could result in a NoClassDefFoundError Exception when an exception is encountered in a query.
- Fix: regression introduced in 1.0.267 that could cause a database with blank keyword idents to fail to load.
- Upgrade: Datomic Local now requires an LTS version of Java 11 or greater.
- Upgraded core.async to 1.6.681.
- Upgraded commons-codec to 1.16.0.
- Upgraded http-client to 1.0.126.
- Upgraded fressian to 0.6.8.

<a id="outline-container-267"></a>

<a id="267"></a>

### 2023/08/16 - 1.0.267

<a id="text-267"></a>

- Changed name to `local` and released under Apache 2.0.
- `:server-type` updated to `datomic-local`.

<a id="outline-container-243"></a>

<a id="243"></a>

### 2022/04/06 - 1.0.243

<a id="text-243"></a>

Upgrade Client to 1.0.126.

<a id="outline-container-242"></a>

<a id="242"></a>

### 2022/01/10 - 1.0.242

<a id="text-242"></a>

Upgrade Client to 1.0.125.

<a id="outline-container-238"></a>

<a id="238"></a>

### 2021/09/27 - 1.0.238

<a id="text-238"></a>

Enhancement: the datalog engine will now do self-unification within a single clause.

<a id="outline-container-235"></a>

<a id="235"></a>

### 2021/07/13 - 0.9.235

<a id="text-235"></a>

- Use the latest Client.
- Fix anomaly where Attr-spec's for boolean attributes with false values failed.

<a id="outline-container-232"></a>

<a id="232"></a>

### 2021/01/20 - 0.9.232

<a id="text-232"></a>

Improvement: enable BigInt fressian handler

<a id="outline-container-229"></a>

<a id="229"></a>

### 2020/11/23 - 0.9.229

<a id="text-229"></a>

- New: change the scale of a [BigDecimal attribute](../../06-reference/01-schema/01-schema-reference/schema-reference.md#db-valuetype) in a transaction.
- Improvement: better error messages for import-cloud.
- Fix: query correctly treats range functions as functions (not as predicates).

<a id="outline-container-225"></a>

<a id="225"></a>

### 2020/10/21 - 0.9.225

<a id="text-225"></a>

- New feature [Memdb](../../01-setup/03-local-setup/local-setup.md#memdb).
- Improvement: increase the limit on the total number of datoms in a transaction imported with [import-cloud](../../04-apis/05-datomic-local-api/datomic-local-api.md#import-cloud) to 16 million.
- Improvement: increase the limit on the length of strings imported with [import-cloud](../../04-apis/05-datomic-local-api/datomic-local-api.md#import-cloud) to 1 million characters.

<a id="outline-container-203"></a>

<a id="203"></a>

### 2020/09/25 - 0.9.203

<a id="text-203"></a>

Provide dev-tools via Cognitect Maven repo.

<a id="outline-container-184"></a>

<a id="184"></a>

### 2020/07/24 - 0.9.184

<a id="text-184"></a>

Improvement: better error message when calling a function that is not in the :allow list of datomic/ion-config.edn.

<a id="outline-container-183"></a>

<a id="183"></a>

### 2020/07/21 - 0.9.183

<a id="text-183"></a>

Update: Use the latest Client API.

<a id="outline-container-180"></a>

<a id="180"></a>

### 2020/07/17 - 0.9.180

<a id="text-180"></a>

- Enhancement: reread the deps-local.edn config file when creating a client.
- Enhancement: provide better feedback while loading and importing databases.
- Enhancement: update client documentation about connecting to dev-local systems.

<a id="outline-container-172"></a>

<a id="172"></a>

### 2020/07/10 - 0.9.172

<a id="text-172"></a>

Initial release.
