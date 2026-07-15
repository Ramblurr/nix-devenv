Package [datomic](../../peer-api-javadoc.md)
<a id="interface-database-predicate-t"></a>

# Interface Database.Predicate\<T\>

<a id="class-description"></a>

Type Parameters:  
`T` - Datom type


Enclosing interface:  
[`Database`](../database/database.md "interface in datomic")

------------------------------------------------------------------------

public static interface Database.Predicate\<T\>

Boolean-valued function for [`filtering`](../database/database.md#filter(datomic.Database.Predicate)) a database.

Since:  
0.8.3627

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  `boolean`
  [`apply`](#apply(datomic.Database,T))`(`[`Database`](../database/database.md "interface in datomic")` db, `[`T`](database-predicate.md "type parameter in Database.Predicate")` val)`
  Database-filtering predicate.


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="apply(datomic.Database,T)"></a>

    <a id="apply(datomic.Database,java.lang.Object)"></a>

    ### apply

    boolean apply([Database](../database/database.md "interface in datomic") db, [T](database-predicate.md "type parameter in Database.Predicate") val)
    Database-filtering predicate.
    Parameters:  
    `db` - a [`Database`](../database/database.md "interface in datomic")

    `val` - a [`Datom`](../datom/datom.md "interface in datomic")

    Returns:  
    true if datom matches the predicate.
