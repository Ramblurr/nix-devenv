Package [datomic](../../peer-api-javadoc.md)
<a id="class-queryrequest"></a>

# Class QueryRequest

[java.lang.Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

datomic.QueryRequest
<a id="class-description"></a>

------------------------------------------------------------------------

public class QueryRequest extends [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

Container for parameters to [`Peer.query(QueryRequest)`](../peer/peer.md#query(datomic.QueryRequest))

Since:  
0.9.5153

- <a id="field-summary"></a>

  ## Field Summary

  Fields
  Modifier and Type
  Field
  Description
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`ARGS`](#ARGS)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`QUERY`](#QUERY)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TIMEOUT`](#TIMEOUT)
   

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")
  [`asData`](#asData())`()`
   
  `static `[`QueryRequest`](query-request.md "class in datomic")
  [`create`](#create(java.lang.Object,java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` query, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... inputs)`
  Creates a QueryRequest object.
  [`QueryRequest`](query-request.md "class in datomic")
  [`timeout`](#timeout(long))`(long timeoutMsec)`
  The number of milliseconds after which a query may be stopped.
  [`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")
  [`toString`](#toString())`()`
   
  <a id="methods-inherited-from-class-java.lang.Object"></a>

  ### Methods inherited from class java.lang.[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

  [`clone`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#clone() "class or interface in java.lang")`, `[`equals`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object) "class or interface in java.lang")`, `[`finalize`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#finalize() "class or interface in java.lang")`, `[`getClass`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#getClass() "class or interface in java.lang")`, `[`hashCode`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#hashCode() "class or interface in java.lang")`, `[`notify`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notify() "class or interface in java.lang")`, `[`notifyAll`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notifyAll() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long) "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long,int) "class or interface in java.lang")


- <a id="field-detail"></a>

  <a id="field-details"></a>

  ## Field Details

  - <a id="ARGS"></a>

    <a id="args"></a>

    ### ARGS

    public static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") ARGS

  - <a id="QUERY"></a>

    <a id="query"></a>

    ### QUERY

    public static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") QUERY

  - <a id="TIMEOUT"></a>

    <a id="timeout"></a>

    ### TIMEOUT

    public static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TIMEOUT

- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="create(java.lang.Object,java.lang.Object...)"></a>

    <a id="create"></a>

    ### create

    public static [QueryRequest](query-request.md "class in datomic") create([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") query, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... inputs)
    Creates a QueryRequest object. `query` and `inputs` take the same form as described in [`Peer.query(Object, Object...)`](../peer/peer.md#query(java.lang.Object,java.lang.Object...))
    Parameters:  
    `query` - a data structure describing the query

    `inputs` - inputs bound to the names in `:in` section of `query`

    Returns:  
    a QueryRequest object that can be passed to [`Peer.query(QueryRequest)`](../peer/peer.md#query(datomic.QueryRequest))

  - <a id="timeout(long)"></a>

    <a id="timeout-2"></a>

    ### timeout

    public [QueryRequest](query-request.md "class in datomic") timeout(long timeoutMsec)
    The number of milliseconds after which a query may be stopped.

    Note: timeout is approximate, it is meant to protect against long running queries, but is not guaranteed to stop after precisely the duration specified.

    Parameters:  
    `timeoutMsec` - number of milliseconds after which a query may be stopped.

    Returns:  
    A reference to the updated QueryRequest so methods can be chained together.

  - <a id="toString()"></a>

    <a id="tostring"></a>

    ### toString

    public [String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") toString()
    Overrides:  
    [`toString`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#toString() "class or interface in java.lang") in class [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

    Returns:  
    A string representation of the QueryRequest

  - <a id="asData()"></a>

    <a id="asdata"></a>

    ### asData

    public [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") asData()
    Returns:  
    A Map representation of the QueryRequest
