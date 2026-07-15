# Datomic

Use this reference for Datomic work in Clojure and JVM projects. Read the smallest official document that answers the question instead of loading the full corpus.

## Lookup Workflow

1. Identify the task and the Datomic edition: Local, Pro, Cloud, or unknown.
2. Choose the closest route below and open its linked documentation.
3. For design or performance advice, also consult [Best Practices](06-reference/08-best-practices/best-practices.md).
4. If no route fits, run `rg -n -i '<search terms>' --glob '*.md'` in this directory and open only the most relevant matches.

| Task | Start here |
| --- | --- |
| Concepts and edition choice | [Introduction](introduction.md) |
| Installation and dependencies | [Setup](01-setup/setup.md) and [Accessing Datomic](02-accessing/accessing.md) |
| First application | [Tutorials](03-tutorials/tutorials.md) |
| Client, Peer, Local, index, log, and stats APIs | [APIs](04-apis/apis.md) |
| Schema and data modeling | [Schema Reference](06-reference/01-schema/01-schema-reference/schema-reference.md) and [Data Modeling](06-reference/01-schema/03-data-modeling/data-modeling.md) |
| Transactions | [Transactions](06-reference/02-transactions/transactions.md) |
| Query and pull | [Query Reference](06-reference/03-query-and-pull/02-query-reference/query-reference.md) and [Pull](06-reference/03-query-and-pull/03-pull/pull.md) |
| Datomic Pro operations | [Transactor Reference](05-operation/01-pro/03-transactor-reference/transactor-reference.md) and [Deployment](05-operation/01-pro/04-datomic-deployment/datomic-deployment.md) |
| Datomic Cloud and Ions | [Cloud Architecture](05-operation/02-cloud/01-cloud-architecture/cloud-architecture.md) and [Ions Overview](07-datomic-cloud-ions/01-ions-overview/ions-overview.md) |
| Analytics | [Analytics Concepts](08-analytics/01-analytics-concepts/analytics-concepts.md) |
| Troubleshooting and compatibility | [Error Handling](04-apis/14-error-handling/error-handling.md), [Cloud Troubleshooting](05-operation/02-cloud/13-cloud-troubleshooting/cloud-troubleshooting.md), and [Releases](11-releases/releases.md) |
| Terminology | [Glossary](12-glossary/glossary.md) |

## Edition Guide

- Local: Prefer for local development, tests, CI, and small embedded applications. Look for `com.datomic/local` or `:server-type :datomic-local`.
- Cloud: Prefer for new AWS production systems and Ions. Look for compute groups, storage stacks, `client-cloud`, or `:server-type :ion`.
- Pro: Use for existing on-premises deployments, custom storage, transactors, or Peer API applications. Look for database URIs, `datomic.api`, peer servers, or transactors.
- If the edition changes the answer and the project does not reveal it, ask one concise question before giving edition-specific instructions.

## Answer Guidance

- Give practical steps before rationale.
- Prefer Clojure CLI examples unless the user requests another build tool.
- Distinguish the Client, Peer, and Local APIs explicitly.
- Cite the local documentation path when an answer depends on specific Datomic behavior.
- Treat this corpus as the source of truth. If it lacks required current information, ask the user for updated local reference material.
- See [Notices and attribution](NOTICE.md) for ownership and licensing information.
