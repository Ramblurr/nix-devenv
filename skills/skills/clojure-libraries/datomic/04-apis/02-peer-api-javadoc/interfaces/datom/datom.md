Package [datomic](../../peer-api-javadoc.md)
<a id="interface-datom"></a>

# Interface Datom

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Datom

An immmutable, point-in-time fact: `[entity, attribute, value, transaction, added]`

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`a`](#a())`()`
  This datom's [attribute](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) id.
  `boolean`
  [`added`](#added())`()`
  Is this datom added or retracted?
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`e`](#e())`()`
  This datom's [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities).
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`get`](#get(int))`(int index)`
  Positional getter, as if datom is tuple of `[e a v tx added]`
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`tx`](#tx())`()`
  This datom's [transaction id](../../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md).
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`v`](#v())`()`
  This datom's value.


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="e()"></a>

    <a id="e"></a>

    ### e

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") e()
    This datom's [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities).
    Returns:  
    entity id

  - <a id="a()"></a>

    <a id="a"></a>

    ### a

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") a()
    This datom's [attribute](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) id.
    Returns:  
    attribute id

  - <a id="v()"></a>

    <a id="v"></a>

    ### v

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") v()
    This datom's value.
    Returns:  
    value

  - <a id="tx()"></a>

    <a id="tx"></a>

    ### tx

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") tx()
    This datom's [transaction id](../../../../06-reference/02-transactions/03-processing-transactions/processing-transactions.md).
    Returns:  
    transaction id

  - <a id="added()"></a>

    <a id="added"></a>

    ### added

    boolean added()
    Is this datom added or retracted?

    When datoms come from [`Database.history()`](../database/database.md#history()), this method can be used to distinguish additions from retractions
    Returns:  
    a boolean indicating whether this datom was added or retracted

  - <a id="get(int)"></a>

    <a id="get"></a>

    ### get

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") get(int index)
    Positional getter, as if datom is tuple of `[e a v tx added]`
    Parameters:  
    `index` - numeric index in the range \[0,4\]

    Returns:  
    the value at this position in the datom
