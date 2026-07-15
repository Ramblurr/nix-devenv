Package [datomic](../../peer-api-javadoc.md)
<a id="interface-attribute"></a>

# Interface Attribute

<a id="class-description"></a>

------------------------------------------------------------------------

public interface Attribute

Programmatic representation of a [schema attribute](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md).

Attribute information always resides in memory, so using this interface is more efficient than accessing the same information from the database via e.g. query.

Since:  
0.9.4470

- <a id="field-summary"></a>

  ## Field Summary

  Fields
  Modifier and Type
  Field
  Description
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`CARDINALITY_MANY`](#CARDINALITY_MANY)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`CARDINALITY_ONE`](#CARDINALITY_ONE)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_BIGDEC`](#TYPE_BIGDEC)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_BIGINT`](#TYPE_BIGINT)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_BOOLEAN`](#TYPE_BOOLEAN)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_BYTES`](#TYPE_BYTES)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_DOUBLE`](#TYPE_DOUBLE)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_FLOAT`](#TYPE_FLOAT)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_FN`](#TYPE_FN)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_INSTANT`](#TYPE_INSTANT)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_KEYWORD`](#TYPE_KEYWORD)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_LONG`](#TYPE_LONG)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_REF`](#TYPE_REF)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_STRING`](#TYPE_STRING)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_URI`](#TYPE_URI)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`TYPE_UUID`](#TYPE_UUID)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`UNIQUE_IDENTITY`](#UNIQUE_IDENTITY)
   
  `static final `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`UNIQUE_VALUE`](#UNIQUE_VALUE)
   

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`cardinality`](#cardinality())`()`
  The attribute's [cardinality](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md)
  `boolean`
  [`hasAVET`](#hasAVET())`()`
  Does this attribute *currently* have an [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?
  `boolean`
  [`hasFulltext`](#hasFulltext())`()`
  Does this attribute have a fulltext index?
  `boolean`
  [`hasNoHistory`](#hasNoHistory())`()`
  Is this a [noHistory](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`id`](#id())`()`
  The attribute's [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities)
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`ident`](#ident())`()`
  The attribute's [ident](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#idents) (programmatic name)
  `boolean`
  [`isComponent`](#isComponent())`()`
  Is this a [component](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?
  `boolean`
  [`isIndexed`](#isIndexed())`()`
  Is this attribute configured for an [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`unique`](#unique())`()`
  Type of the attribute's [unique index](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#unique-identities), if any.
  [`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`valueType`](#valueType())`()`
  The attribute's [value type](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md)


- <a id="field-detail"></a>

  <a id="field-details"></a>

  ## Field Details

  - <a id="CARDINALITY_MANY"></a>

    <a id="cardinality-many"></a>

    ### CARDINALITY_MANY

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") CARDINALITY_MANY

  - <a id="CARDINALITY_ONE"></a>

    <a id="cardinality-one"></a>

    ### CARDINALITY_ONE

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") CARDINALITY_ONE

  - <a id="UNIQUE_IDENTITY"></a>

    <a id="unique-identity"></a>

    ### UNIQUE_IDENTITY

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") UNIQUE_IDENTITY

  - <a id="UNIQUE_VALUE"></a>

    <a id="unique-value"></a>

    ### UNIQUE_VALUE

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") UNIQUE_VALUE

  - <a id="TYPE_BIGDEC"></a>

    <a id="type-bigdec"></a>

    ### TYPE_BIGDEC

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_BIGDEC

  - <a id="TYPE_BIGINT"></a>

    <a id="type-bigint"></a>

    ### TYPE_BIGINT

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_BIGINT

  - <a id="TYPE_BOOLEAN"></a>

    <a id="type-boolean"></a>

    ### TYPE_BOOLEAN

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_BOOLEAN

  - <a id="TYPE_BYTES"></a>

    <a id="type-bytes"></a>

    ### TYPE_BYTES

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_BYTES

  - <a id="TYPE_DOUBLE"></a>

    <a id="type-double"></a>

    ### TYPE_DOUBLE

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_DOUBLE

  - <a id="TYPE_FN"></a>

    <a id="type-fn"></a>

    ### TYPE_FN

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_FN

  - <a id="TYPE_FLOAT"></a>

    <a id="type-float"></a>

    ### TYPE_FLOAT

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_FLOAT

  - <a id="TYPE_INSTANT"></a>

    <a id="type-instant"></a>

    ### TYPE_INSTANT

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_INSTANT

  - <a id="TYPE_KEYWORD"></a>

    <a id="type-keyword"></a>

    ### TYPE_KEYWORD

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_KEYWORD

  - <a id="TYPE_LONG"></a>

    <a id="type-long"></a>

    ### TYPE_LONG

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_LONG

  - <a id="TYPE_REF"></a>

    <a id="type-ref"></a>

    ### TYPE_REF

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_REF

  - <a id="TYPE_STRING"></a>

    <a id="type-string"></a>

    ### TYPE_STRING

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_STRING

  - <a id="TYPE_URI"></a>

    <a id="type-uri"></a>

    ### TYPE_URI

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_URI

  - <a id="TYPE_UUID"></a>

    <a id="type-uuid"></a>

    ### TYPE_UUID

    static final [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") TYPE_UUID

- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="id()"></a>

    <a id="id"></a>

    ### id

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") id()
    The attribute's [entity id](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#entities)
    Returns:  
    an entity id

  - <a id="ident()"></a>

    <a id="ident"></a>

    ### ident

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") ident()
    The attribute's [ident](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#idents) (programmatic name)
    Returns:  
    an ident

  - <a id="valueType()"></a>

    <a id="valuetype"></a>

    ### valueType

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") valueType()
    The attribute's [value type](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md)
    Returns:  
    a value type

  - <a id="cardinality()"></a>

    <a id="cardinality"></a>

    ### cardinality

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") cardinality()
    The attribute's [cardinality](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md)
    Returns:  
    either [`CARDINALITY_MANY`](#CARDINALITY_MANY) or [`CARDINALITY_ONE`](#CARDINALITY_ONE)

  - <a id="unique()"></a>

    <a id="unique"></a>

    ### unique

    [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") unique()
    Type of the attribute's [unique index](../../../../06-reference/01-schema/04-identity-and-uniqueness/identity-and-uniqueness.md#unique-identities), if any.
    Returns:  
    one of [`UNIQUE_IDENTITY`](#UNIQUE_IDENTITY), [`UNIQUE_VALUE`](#UNIQUE_VALUE), or null

  - <a id="isComponent()"></a>

    <a id="iscomponent"></a>

    ### isComponent

    boolean isComponent()
    Is this a [component](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?
    Returns:  
    true if `:db/isComponent` true for this attribute

  - <a id="isIndexed()"></a>

    <a id="isindexed"></a>

    ### isIndexed

    boolean isIndexed()
    Is this attribute configured for an [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?
    Returns:  
    true if `:db/index` true for this attribute, or attribute is unique

  - <a id="hasAVET()"></a>

    <a id="hasavet"></a>

    ### hasAVET

    boolean hasAVET()
    Does this attribute *currently* have an [AVET index](../../../../06-reference/04-indexes/01-index-model/index-model.md#avet)?

    When you [alter](../../../../06-reference/01-schema/02-changing-schema/changing-schema.md) an existing schema, indexes are created in the background after setting `:db/index` to true. This method returns true once a recently-added index is ready for use.
    Returns:  
    true if AVET index available for this attribute

  - <a id="hasNoHistory()"></a>

    <a id="hasnohistory"></a>

    ### hasNoHistory

    boolean hasNoHistory()
    Is this a [noHistory](../../../../06-reference/01-schema/01-schema-reference/schema-reference.md) attribute?
    Returns:  
    true if `:db/noHistory` true for this attribute

  - <a id="hasFulltext()"></a>

    <a id="hasfulltext"></a>

    ### hasFulltext

    boolean hasFulltext()
    Does this attribute have a fulltext index?
    Returns:  
    true if `:db/fulltext` true for this attribute
