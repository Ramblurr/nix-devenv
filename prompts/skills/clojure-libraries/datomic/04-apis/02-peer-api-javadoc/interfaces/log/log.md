Package [datomic](../../peer-api-javadoc.md)
<a id="interface-log"></a>

# Interface Log

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Log

Implements the [Log API](../../../09-log-api/additional-log-api/additional-log-api.md).

Since:  
0.8.4122

- <a id="field-summary"></a>

  ## Field Summary

  Fields
  Modifier and Type
  Field
  Description
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`DATA`](#DATA)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`T`](#T)
   

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")`<`[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")`>`
  [`txRange`](#txRange(java.lang.Object,java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` startT, `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` endT)`
  Returns a range of transactions in log, starting at start, or from beginning if start is null, and ending before end, or through end of log if end is null.


- <a id="field-detail"></a>

  <a id="field-details"></a>

  ## Field Details

  - <a id="T"></a>

    <a id="t"></a>

    ### T

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") T

  - <a id="DATA"></a>

    <a id="data"></a>

    ### DATA

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") DATA

- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="txRange(java.lang.Object,java.lang.Object)"></a>

    <a id="txrange"></a>

    ### txRange

    [Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")\<[Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")\> txRange([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") startT, [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") endT)
    Returns a range of transactions in log, starting at start, or from beginning if start is null, and ending before end, or through end of log if end is null. Each transaction is a map with the following keys:

    |         |                                                                  |
    |---------|------------------------------------------------------------------|
    | `T`     | the T point of the transaction                                   |
    | `DATA`  | a Collection of the Datoms asserted/retracted by the transaction |

    Transaction map keys

    Parameters:  
    `startT` - a [time-point](../../../../12-glossary/glossary.md#time-point) or null

    `endT` - a [time-point](../../../../12-glossary/glossary.md#time-point) or null

    Returns:  
    an Iterable of transaction maps occurring between start (inclusive) and end (exclusive)
