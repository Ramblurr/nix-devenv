Package [datomic](../../peer-api-javadoc.md)
<a id="interface-listenablefuture-t"></a>

# Interface ListenableFuture\<T\>

<a id="class-description"></a>

All Superinterfaces:  
[`Future`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html "class or interface in java.util.concurrent")`<T>`

------------------------------------------------------------------------

public interface ListenableFuture\<T\> extends [Future](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html "class or interface in java.util.concurrent")\<T\>

A future that supports completion listeners.

Since:  
0.8.3591

- <a id="nested-class-summary"></a>

  ## Nested Class Summary

  <a id="nested-classes-inherited-from-class-java.util.concurrent.Future"></a>

  ## Nested classes/interfaces inherited from interface java.util.concurrent.[Future](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html "class or interface in java.util.concurrent")

  [`Future.State`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.State.html "class or interface in java.util.concurrent")

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  `void`
  [`addListener`](#addListener(java.lang.Runnable,java.util.concurrent.Executor))`(`[`Runnable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Runnable.html "class or interface in java.lang")` listener, `[`Executor`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Executor.html "class or interface in java.util.concurrent")` executor)`
  Register a listener to run on the given executor.
  <a id="methods-inherited-from-class-java.util.concurrent.Future"></a>

  ### Methods inherited from interface java.util.concurrent.[Future](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html "class or interface in java.util.concurrent")

  [`cancel`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#cancel(boolean) "class or interface in java.util.concurrent")`, `[`exceptionNow`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#exceptionNow() "class or interface in java.util.concurrent")`, `[`get`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#get() "class or interface in java.util.concurrent")`, `[`get`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#get(long,java.util.concurrent.TimeUnit) "class or interface in java.util.concurrent")`, `[`isCancelled`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#isCancelled() "class or interface in java.util.concurrent")`, `[`isDone`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#isDone() "class or interface in java.util.concurrent")`, `[`resultNow`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#resultNow() "class or interface in java.util.concurrent")`, `[`state`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Future.html#state() "class or interface in java.util.concurrent")


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="addListener(java.lang.Runnable,java.util.concurrent.Executor)"></a>

    <a id="addlistener"></a>

    ### addListener

    void addListener([Runnable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Runnable.html "class or interface in java.lang") listener, [Executor](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/concurrent/Executor.html "class or interface in java.util.concurrent") executor)
    Register a listener to run on the given executor. The listener will run once and only once, if and when the Future's work is complete. If the future has completed already, the listener will run immediately. Ordering of listeners is not guaranteed.
    Parameters:  
    `listener` - the listener to run

    `executor` - the executor to run the listener
