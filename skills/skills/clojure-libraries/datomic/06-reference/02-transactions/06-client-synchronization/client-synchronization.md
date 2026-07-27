<a id="content"></a>

<a id="synchronization"></a>

# Synchronization

<a id="outline-container-background"></a>

<a id="background"></a>

## Background

<a id="text-background"></a>

Datomic stores data immutably. When you ask a connection for a db value, you are given a recent value of the db. All clients see a valid, [consistent](../05-acid/acid.md) view. You can never see partial transactions, corruption/regression of timelines, causal anomalies etc. Datomic is always 'business rules' valid, and causally consistent.

<a id="outline-container-motivation"></a>

<a id="motivation"></a>

## Motivation

<a id="text-motivation"></a>

That does not mean that every process sees the same thing simultaneously. It is never the case that everyone sees the same thing "at the same time" in a live distributed system. There is no inherently shared truth: you might convey a message to me about X at the speed of light, but I can only perceive X at the speed of sound. Thus, I know X is coming, but I might have to wait for it.

This means that some caller A might commit a transaction and tell caller B about it before B is informed via the normal channels. This is an interesting case, as it has to do with perception and propagation delays. It is not a question of consistency, it is a question of communication synchronization.

This comes up when you would like to read-your-own-writes via the Client API (e.g. when requests hit different peer servers via a load balancer), and when there is out-of-band communication of writes (A tells B about its write before Datomic's propagation does).

<a id="outline-container-sync"></a>

<a id="sync"></a>

## Sync

<a id="text-sync"></a>

[Peer API](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/sync) \| [Client API](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-sync)

`sync` takes a basis point `t`, and it returns a database value that includes point `t`. This does not cause any additional network traffic, and it saves you from having to poll for arrival. `sync` is the preferred method to use for synchronizing between Datomic callers:

- Caller A gets the basis `t` for some transaction of interest
- Caller A records the `t` value in its communication to B, e.g. via cookie.

You can easily get the basis `t` for any db value you have in hand using the [Peer API](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/basis-t) or [Client API](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-db).

<a id="outline-container-comparison"></a>

<a id="comparison"></a>

## Comparison to As-Of

<a id="text-comparison"></a>

`sync` ensures (by maybe waiting) that you have up to some time point `t`. [as-of](../../06-time-in-datomic/time-in-datomic.md#as-of) ensures (by maybe filtering) that you have not more than some time point `t`. In combination, they allow separate processes to know that they are working from the same basis.

<a id="outline-container-conclusion"></a>

<a id="conclusion"></a>

## Conclusion

<a id="text-conclusion"></a>

`sync` is powerful, and removes the need to find a particular server to handle a synchronization between callers. That said, use `sync` only when necessary. Datomic is designed to leverage the inherent parallelism possible given immutable, accumulate-only semantics and distributed storage. Notifications to peers and cluster nodes are sent at the same time as the acknowledgment to the caller submitting the transaction, and thus are as 'simultaneous' as network communication can be. Use `sync` only to enforce cross-client causal relationships.
