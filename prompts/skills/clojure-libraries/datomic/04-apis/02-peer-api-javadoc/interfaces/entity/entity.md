Package [datomic](../../peer-api-javadoc.md)
<a id="interface-entity"></a>

# Interface Entity

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Entity

Implements the [Entity API](../../../../06-reference/07-entities/entities.md) for associative navigation by attribute keys. An Entity is lazy - the values of its attributes are not obtained from the db until get or touch are called, after which they are cached in the entity. Note that entities have reference-like equality semantics - Two entities are equal if they have the same id and their databases have the same id

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Database`](../database/database.md "interface in datomic")
  [`db`](#db())`()`
   
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`get`](#get(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` key)`
  Gets the value of the attribute named by key, and is polymorphic on key type cardinality :many attributes will always return a collection, even when only one value
  [`Set`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Set.html "class or interface in java.util")`<`[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")`>`
  [`keySet`](#keySet())`()`
   
  [`Entity`](entity.md "interface in datomic")
  [`touch`](#touch())`()`
  Touches all of the attributes of the entity, including any component entities recursively.


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="get(java.lang.Object)"></a>

    <a id="get"></a>

    ### get

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") get([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") key)
    Gets the value of the attribute named by key, and is polymorphic on key type cardinality :many attributes will always return a collection, even when only one value
    Parameters:  
    `key` - A colon-prefixed string, e.g. ":user/firstName"

    Returns:  
    the value(s) of that attribute, or null if none

  - <a id="touch()"></a>

    <a id="touch"></a>

    ### touch

    [Entity](entity.md "interface in datomic") touch()
    Touches all of the attributes of the entity, including any component entities recursively.
    Returns:  
    this Entity

  - <a id="keySet()"></a>

    <a id="keyset"></a>

    ### keySet

    [Set](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Set.html "class or interface in java.util")\<[String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")\> keySet()
    Returns:  
    the key names of the attributes

  - <a id="db()"></a>

    <a id="db"></a>

    ### db

    [Database](../database/database.md "interface in datomic") db()
    Returns:  
    the database value that is the basis for this entity
