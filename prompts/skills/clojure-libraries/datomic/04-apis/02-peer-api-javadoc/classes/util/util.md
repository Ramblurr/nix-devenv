Package [datomic](../../peer-api-javadoc.md)
<a id="class-util"></a>

# Class Util

[java.lang.Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

datomic.Util
<a id="class-description"></a>

------------------------------------------------------------------------

public final class Util extends [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

Utilities for creating and using data structures.

- <a id="method-summary"></a>

  ## Method Summary

  <a id="method-summary-table"></a>

  <a id="method-summary-table.tabpanel"></a>

  Modifier and Type
  Method
  Description
  `static `[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")
  [`list`](#list(java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... items)`
  Creates an immutable List.
  `static `[`Map`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util")
  [`map`](#map(java.lang.Object...))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")`... keyvals)`
  Creates an immutable Map.
  `static `[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")
  [`name`](#name(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` k)`
  Returns the name part of a keyword or symbol.
  `static `[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")
  [`namespace`](#namespace(java.lang.Object))`(`[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")` k)`
  Returns the namespace part of a keyword or symbol.
  `static `[`Object`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")
  [`read`](#read(java.lang.String))`(`[`String`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang")` source)`
  Reads one item from source, returning it.
  `static `[`List`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util")
  [`readAll`](#readAll(java.io.Reader))`(`[`Reader`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/Reader.html "class or interface in java.io")` reader)`
  Reads all the data in reader, returning a List.
  `static `[`Stream`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream")
  [`streamOn`](#streamOn(java.lang.Iterable))`(`[`Iterable`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang")` it)`
  Create a stream on an immutable Iterable.
  <a id="methods-inherited-from-class-java.lang.Object"></a>

  ### Methods inherited from class java.lang.[Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")

  [`clone`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#clone() "class or interface in java.lang")`, `[`equals`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#equals(java.lang.Object) "class or interface in java.lang")`, `[`finalize`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#finalize() "class or interface in java.lang")`, `[`getClass`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#getClass() "class or interface in java.lang")`, `[`hashCode`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#hashCode() "class or interface in java.lang")`, `[`notify`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notify() "class or interface in java.lang")`, `[`notifyAll`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#notifyAll() "class or interface in java.lang")`, `[`toString`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#toString() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait() "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long) "class or interface in java.lang")`, `[`wait`](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html#wait(long,int) "class or interface in java.lang")


- <a id="method-detail"></a>

  <a id="method-details"></a>

  ## Method Details

  - <a id="name(java.lang.Object)"></a>

    <a id="name"></a>

    ### name

    public static [String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") name([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") k)
    Returns the name part of a keyword or symbol.
    Parameters:  
    `k` - - a keyword or symbol

    Returns:  
    the name

  - <a id="namespace(java.lang.Object)"></a>

    <a id="namespace"></a>

    ### namespace

    public static [String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") namespace([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") k)
    Returns the namespace part of a keyword or symbol.
    Parameters:  
    `k` - - a Keyword

    Returns:  
    the namespace

  - <a id="list(java.lang.Object...)"></a>

    <a id="list"></a>

    ### list

    public static [List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") list([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... items)
    Creates an immutable List.
    Parameters:  
    `items` - - Objects to be included in the List

    Returns:  
    an unmodifiable List

  - <a id="map(java.lang.Object...)"></a>

    <a id="map"></a>

    ### map

    public static [Map](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Map.html "class or interface in java.util") map([Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang")... keyvals)
    Creates an immutable Map.
    Parameters:  
    `keyvals` - - pairs to include in the Map, written as key1, value1, key2, value2, and so on

    Returns:  
    an unmodifiable Map

  - <a id="read(java.lang.String)"></a>

    <a id="read"></a>

    ### read

    public static [Object](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Object.html "class or interface in java.lang") read([String](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/String.html "class or interface in java.lang") source)
    Reads one item from source, returning it.
    Parameters:  
    `source` - an [edn](https://github.com/edn-format/edn) string

    Returns:  
    the object read

  - <a id="readAll(java.io.Reader)"></a>

    <a id="readall"></a>

    ### readAll

    public static [List](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/List.html "class or interface in java.util") readAll([Reader](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/io/Reader.html "class or interface in java.io") reader)
    Reads all the data in reader, returning a List. Closes reader.
    Parameters:  
    `reader` - - the [edn](https://github.com/edn-format/edn) data to parse.

    Returns:  
    a List for the parsed data.

  - <a id="streamOn(java.lang.Iterable)"></a>

    <a id="streamon"></a>

    ### streamOn

    public static [Stream](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/stream/Stream.html "class or interface in java.util.stream") streamOn([Iterable](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Iterable.html "class or interface in java.lang") it)
    Create a stream on an immutable Iterable.
    Parameters:  
    `it` - an Iterator

    Returns:  
    a sequential Stream
