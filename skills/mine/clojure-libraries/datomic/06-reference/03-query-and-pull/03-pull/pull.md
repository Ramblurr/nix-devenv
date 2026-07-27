<a id="content"></a>

<a id="pull"></a>

# Pull

Pull is a declarative way to make hierarchical (and possibly nested) selections of information about entities. Pull applies a *pattern* to a collection of entities, building a map for each entity. Pull is available

- via the standalone `pull` API [Peer](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/pull) \| [Client](../../../04-apis/03-client-api-clojuredoc/client-api-clojuredoc.md#var-pull)
- via the [standalone `pull-many` API in Peer](../../../04-apis/01-peer-api-clojuredoc/peer-api-clojuredoc.md#datomic.api/pull-many)
- as a [find specification](../02-query-reference/query-reference.md#pull-expressions) in query

Patterns support [forward](#attribute-names) and [reverse](#reverse-lookup) attribute navigation, [wildcarding](#wildcard-specifications), [nesting](#nesting), [recursion](#recursive-specifications), [naming control](#as-option), [transformation](#xform-option), [defaults](#default-option), and [limits](#limit-option) on the results returned. Entities can be passed to pull as any kind of [entity identifier](../../02-transactions/02-transaction-data/transaction-data.md#entity-identifiers): [entity ids](../../02-transactions/02-transaction-data/transaction-data.md#eid), [idents](../../02-transactions/02-transaction-data/transaction-data.md#ident), or [lookup refs](../../02-transactions/02-transaction-data/transaction-data.md#lookup-ref).

Pull patterns are written in the [Extensible Data Notation](https://github.com/edn-format/edn) (edn), which is programming language neutral. In programs, you can create patterns programmatically out of your basic language data types, e.g. Java Strings, Lists, and Maps. Alternatively, you can pass the pattern argument as a serialized edn string.

The results below are also written with edn, and they use an ellipsis `...` where large results have been elided for brevity.

If you want to follow along at a REPL, most of the examples on this page use the [mbrainz-subset](https://github.com/Datomic/mbrainz-importer#readme) database and can be found in the [Day of Datomic Cloud](https://github.com/cognitect-labs/day-of-datomic-cloud/blob/master/tutorial/pull.repl) repository and are covered in the [Day of Datomic Cloud](https://youtu.be/qplsC2Q2xBA?t=775) video sessions.

<a id="outline-container-example-notes"></a>

<a id="example-notes"></a>

## Example Notes

<a id="text-example-notes"></a>

The examples will use the following:

``` clojure
(def dylan-harrison-sessions (ffirst (d/q '[:find ?release
                                           :where [?zimbo :artist/name "Bob Dylan"]
                                                  [?magpie :artist/name "George Harrison"]
                                                  [?release :release/artists ?zimbo]
                                                  [?release :release/artists ?magpie]]
                                         db)))

(def ghost-riders (ffirst (d/q '[:find ?track
                                 :in $ ?release ?trackno
                                 :where [?release :release/media ?medium]
                                        [?medium :medium/tracks ?track]
                                        [?track :track/position ?trackno]]
                               db
                               dylan-harrison-sessions
                               11)))

(def led-zeppelin (ffirst (d/q '[:find ?artist
                                 :where [?artist :artist/name "Led Zeppelin"]]
                               db)))


(def mccartney (ffirst (d/q '[:find ?artist
                              :where [?artist :artist/name "Paul McCartney"]]
                               db)))

(def concert-for-bangla-desh (ffirst (d/q '[:find ?release-name
                                            :where [?release-name :release/name "The Concert for Bangla Desh"]]
                                          db)))

(def dark-side-of-the-moon (ffirst (d/q '[:find ?release-name
                                            :where [?release-name :release/name "The Dark Side of the Moon"]]
                                          db)))
```

<a id="outline-container-pull-grammar"></a>

<a id="pull-grammar"></a>

## Pull Grammar

<a id="text-pull-grammar"></a>

<a id="outline-container-grammar-syntax"></a>

<a id="grammar-syntax"></a>

### Grammar Syntax

<a id="text-grammar-syntax"></a>

```
'' literal
"" string
[] = list or vector
{} = map {k1 v1 ...}
() grouping
| choice
+ one or more
```

<a id="outline-container-pull-pattern-grammar"></a>

<a id="pull-pattern-grammar"></a>

### Pull Pattern Grammar

<a id="text-pull-pattern-grammar"></a>

```
pattern             = [attr-spec+]
attr-spec           = attr-name | wildcard | map-spec | attr-expr
attr-name           = an edn keyword that names an attr
map-spec            = { ((attr-name | attr-expr) (pattern | recursion-limit))+ }
attr-expr           = [attr-name attr-option+] | legacy-attr-expr
as-expr             = [attr-name ":as" any-value]
limit-expr          = [attr-name ":limit" (positive-number | nil)] 
default-expr        = [attr-name ":default" any-value]
xform-expr          = [attr-name ":xform" symbol]
attr-option         = as-expr | limit-expr | default-expr | xform-expr
wildcard            = "*" or '*'
recursion-limit     = positive-number | '...'
legacy-attr-expr    = legacy-limit-expr | legacy-default-expr
legacy-limit-expr   = [("limit" | 'limit') attr-name (positive-number | nil)]
legacy-default-expr = [("default" | 'default') attr-name any-value]
```

Terminals such as "limit" can be strings, but where languages have a symbol type you should prefer the idiomatic symbolic type, e.g. `(limit :friends 100)` in Clojure instead of `("limit" "friends" 100)`.

<a id="outline-container-pattern"></a>

<a id="pattern"></a>

## Patterns

<a id="text-pattern"></a>

A pattern is a list of Attribute Specifications.

```
pattern            = [attr-spec+]
```

<a id="outline-container-attribute-specifications"></a>

<a id="attribute-specifications"></a>

## Attribute Specifications

<a id="text-attribute-specifications"></a>

```
attr-spec           = attr-name | wildcard | map-spec | attr-expr
attr-expr           = [attr-name attr-option+] | legacy-attr-expr
attr-option         = as-expr | limit-expr | default-expr | xform-expr
wildcard            = "*" or '*'
recursion-limit     = positive-number | '...'
legacy-attr-expr    = legacy-limit-expr | legacy-default-expr
legacy-limit-expr   = [("limit" | 'limit') attr-name (positive-number | nil)]
legacy-default-expr = [("default" | 'default') attr-name any-value]
```

An attribute spec specifies an attribute to be returned, and (optionally) what additional transformations to perform on the value before it is returned. Attribute specs can be attribute names, wildcards, map specs, or attribute expressions.

<a id="outline-container-attribute-names"></a>

<a id="attribute-names"></a>

## Attribute Names

<a id="text-attribute-names"></a>

```
attr-name          = an edn keyword that names an attr
```

An attribute spec names an attribute, with an optional leading underscore on the name part of the keyword to reverse the direction of navigation.

<a id="outline-container-attribute-name-example"></a>

<a id="attribute-name-example"></a>

### Attribute Name Example

<a id="text-attribute-name-example"></a>

The following pattern uses two attribute names to return an `:artist/name` and `:artist/startYear`, pulling on `led-zeppelin`:

``` clojure
;; pattern
[:artist/name :artist/startYear]

;; Example
(d/pull db '[:artist/name :artist/startYear] led-zeppelin)
```

``` clojure
=> #:artist{:name "Led Zeppelin", :startYear 1968}
```

<a id="outline-container-reverse-lookup"></a>

<a id="reverse-lookup"></a>

### Reverse Lookup

<a id="text-reverse-lookup"></a>

An underscore prefix (`_`) on the name part of an attribute ident causes the attribute to be navigated in reverse. If you name your attributes with an underscore leading the name portion of the keyword, those attributes cannot be used with reverse lookup.

Normally, `pull` returns a map of attributes and values (which may be nested entities) selected from the entity supplied as the last argument to the `pull` call. For example, `(d/pull db [:release/artists] led-zeppelin)` would attempt to pull the `:release/artists` attribute from the `led-zeppelin` entity.

The underscore prefix reverses the direction of a `pull`, so `(d/pull db [:release/_artists] led-zeppelin)` will pull all of the entities that have a `:release/artists` attribute with the value of `led-zeppelin`.

<a id="outline-container-attribute-name-reverse-lookup-example"></a>

<a id="attribute-name-reverse-lookup-example"></a>

### Attribute Name Reverse Lookup Example

<a id="text-attribute-name-reverse-lookup-example"></a>

As an exploratory measure `led-zeppelin` is pulled with a [wildcard](#wildcard-specifications). `:release/artists` is not part of the result.

You can navigate 'backwards' from `:release/artists` to find the releases with a reference to `led-zeppelin` by pulling `:release/_artists`

Attributes like `:artist/startYear` or `:artist/name` would not work with reverse lookup as there is no reference value.

``` clojure
(d/pull db '[:release/artists] led-zeppelin)
```

``` clojure
=> {}
```

``` clojure
;; What does led-zeppelin have?

(d/pull db '[*] led-zeppelin)
```

``` clojure
=>
{:artist/sortName "Led Zeppelin",
 :artist/name "Led Zeppelin",
 :artist/type #:db{:id 70746976177619070, :ident :artist.type/group},
 :artist/country #:db{:id 47850746040811801, :ident :country/GB},
 :artist/gid #uuid "678d88b2-87b0-403b-b63d-5da7465aecc3",
 :artist/endDay 25,
 :artist/startYear 1968,
 :artist/endMonth 9,
 :artist/endYear 1980,
 :db/id 2458507999719892}
;; :release/artists is not there...
```

``` clojure
(d/pull db '[* :release/_artists] led-zeppelin)
```

``` clojure
=>
{:artist/sortName "Led Zeppelin",
 :artist/name "Led Zeppelin",
 :artist/type #:db{:id 70746976177619070, :ident :artist.type/group},
 :artist/country #:db{:id 47850746040811801, :ident :country/GB},
 :artist/gid #uuid "678d88b2-87b0-403b-b63d-5da7465aecc3",
 :artist/endDay 25,
 :artist/startYear 1968,
 :artist/endMonth 9,
 :release/_artists
 [#:db{:id 12591607161327185}   ;; ----.
  #:db{:id 13611953951903311}   ;;     | 
  #:db{:id 14614708556444205}   ;;     | 
  #:db{:id 20349761206917151}   ;;     | 
  #:db{:id 27505382880490028}   ;;     | 
  #:db{:id 30606005670815267}   ;;     | 
  #:db{:id 36437815344539172}   ;;     | 
  #:db{:id 38834750693087262}   ;;     | 
  #:db{:id 43703388180886059}   ;;     |-- Releases
  #:db{:id 43910096366902013}   ;;     | 
  #:db{:id 45994770413170389}   ;;     | 
  #:db{:id 49236130691853680}   ;;     | 
  #:db{:id 51514318784597586}   ;;     | 
  #:db{:id 54157544737773785}   ;;     | 
  #:db{:id 58683134597703205}   ;;     | 
  #:db{:id 66718365573484112}   ;;     | 
  #:db{:id 71402285107818196}], ;; ----' 
 :artist/endYear 1980,
 :db/id 2458507999719892}
```

<a id="outline-container-map-specifications"></a>

<a id="map-specifications"></a>

## Map Specification

<a id="text-map-specifications"></a>

```
map-spec           = { ((attr-name | limit-expr) (pattern | recursion-limit))+ }
limit-expr         = [("limit" | 'limit') attr-name (positive-number | nil)]
recursion-limit    = positive-number | '...'
```

You can explicitly specify the handling of referenced entities by using a map instead of just an attribute name. The simplest map specification is a map specifying a specific `pattern` for a particular `attr-name`.

<a id="outline-container-map-specification-example"></a>

<a id="map-specification-example"></a>

### Map Specification Example

<a id="text-map-specification-example"></a>

The `:track/artists` attribute appears in a map spec, causing the `:db/id` and `:artist/name` to be sub-pulled for each artist on the track `ghost-riders`.

``` clojure
(d/pull db '[:track/name {:track/artists [:db/id :artist/name]}] ghost-riders)
```

``` clojure
=>
{:track/artists [{:db/id 17592186048186, :artist/name "Bob Dylan"}
                 {:db/id 17592186049854, :artist/name "George Harrison"}],
 :track/name "Ghost Riders in the Sky"}
```

<a id="outline-container-nesting"></a>

<a id="nesting"></a>

### Map Specification Nesting Example

<a id="text-nesting"></a>

Map specs can nest arbitrarily. The pattern below pulls `concert-for-bangla-desh`'s media's tracks' titles and artists' names:

``` clojure
(d/pull db '[{:release/media
              [{:medium/tracks
                [:track/name {:track/artists [:artist/name]}]}]}] concert-for-bangla-desh)
```

``` clojure
=>
[{:medium/tracks
    [{:track/artists
        [{:artist/name "Ravi Shankar"} {:artist/name "George Harrison"}],
        :track/name "George Harrison / Ravi Shankar Introduction"}
    {:track/artists [{:artist/name "Ravi Shankar"}],
        :track/name "Bangla Dhun"}]}
 {:medium/tracks
     [{:track/artists [{:artist/name "George Harrison"}],
         :track/name "Wah-Wah"}
     {:track/artists [{:artist/name "George Harrison"}],
         :track/name "My Sweet Lord"}
     {:track/artists [{:artist/name "George Harrison"}],
         :track/name "Awaiting on You All"}
     {:track/artists [{:artist/name "Billy Preston"}],
         :track/name "That's the Way God Planned It"}]
             ...]}    
```

<a id="outline-container-attribute-with-options"></a>

<a id="attribute-with-options"></a>

## Attribute Spec

<a id="text-attribute-with-options"></a>

```
attr-spec           = attr-name | wildcard | map-spec | attr-expr | xform-expr
attr-expr           = [attr-name attr-option+] | legacy-attr-expr
attr-option         = as-expr | limit-expr | default-expr
```

You can use an attribute spec to declare various aspects of the corresponding values returned by Pull.

Note that the pattern appears in a seq. This necessitates that the whole clause be quoted or that the pattern is in a vector.

<a id="outline-container-as-option"></a>

<a id="as-option"></a>

## :as Option

<a id="text-as-option"></a>

```
[attr-name ":as" any-value]
```

The `:as` option can be used to declare what an attribute should be renamed to in the result map.

<a id="outline-container-as-example"></a>

<a id="as-example"></a>

### :as Option Example

<a id="text-as-example"></a>

The following pattern uses an :as option to pull an `:artist/name`, replacing the key in the result map with the string "Band Name", pulling on `led-zeppelin`.

``` clojure
(d/pull db '[[:artist/name :as "Band Name"]] led-zeppelin)
```

``` clojure
=> {"Band Name" "Led Zeppelin"}
```

<a id="outline-container-limit-option"></a>

<a id="limit-option"></a>

## :limit Option

<a id="text-limit-option"></a>

```
[attr-name ":limit" (positive-number | nil)]
```

By default, Pull will return the first 1000 values for a cardinality-many attribute, but you can control that by providing either a positive number or `nil for` the :limit option. All values for a cardinality-many attribute will be returned if you explicitly provide a `nil` limit.

<a id="outline-container-limit-example"></a>

<a id="limit-example"></a>

### :limit Option Example

<a id="text-limit-example"></a>

To return only 10 of `led-zeppelin`'s tracks:

``` clojure
(d/pull db '[:artist/name [:track/_artists :limit 10]] led-zeppelin)
```

``` clojure
=>
{:artist/name "Led Zeppelin",
 :track/_artists
 [{:db/id 17592186057344}
  {:db/id 17592186057345}
  {:db/id 17592186057346}
  {:db/id 17592186057347}
  {:db/id 17592186057348}
  {:db/id 17592186057349}
  {:db/id 17592186057350}
  {:db/id 17592186057351}
  {:db/id 17592186057352}
  {:db/id 17592186057355}]}
```

<a id="outline-container-limit-inside-a-map-specification-example"></a>

<a id="limit-inside-a-map-specification-example"></a>

### :limit Inside a Map Specification Example

<a id="text-limit-inside-a-map-specification-example"></a>

Pulling from `led-zeppelin`, you can get a limited set of nested track names with:

``` clojure
(d/pull db '[{[:track/_artists :limit 10] [:track/name]}] led-zeppelin)
```

``` clojure
=>
{:track/_artists
 [{:track/name "Whole Lotta Love"}
  {:track/name "What Is and What Should Never Be"}
  {:track/name "The Lemon Song"}
  {:track/name "Thank You"}
  {:track/name "Heartbreaker"}
  {:track/name "Living Loving Maid (She's Just a Woman)"}
  {:track/name "Ramble On"}
  {:track/name "Moby Dick"}
  {:track/name "Bring It on Home"}
  {:track/name "Whole Lotta Love"}]}
```

<a id="outline-container-nil-limit-example"></a>

<a id="nil-limit-example"></a>

### Nil :limit Example

<a id="text-nil-limit-example"></a>

The pattern below returns all of Led Zeppelin's tracks, without limit:

``` clojure
(d/pull db '[:artist/name [:track/_artists :limit nil]] led-zeppelin)
```

``` clojure
=>
{:artist/name "Led Zeppelin",
 :track/_artists
 [{:db/id 17592186057344}
  {:db/id 17592186057345}
  {:db/id 17592186057346}
  {:db/id 17592186057347}
  {:db/id 17592186057348}
  {:db/id 17592186057349}
  {:db/id 17592186057350}
  {:db/id 17592186057351}
  {:db/id 17592186057352}
  {:db/id 17592186057355}
  {:db/id 17592186057356}
  {:db/id 17592186057357}
  {:db/id 17592186057358}
  {:db/id 17592186057359}
  {:db/id 17592186057360}
  {:db/id 17592186057361}
  {:db/id 17592186057362}
  {:db/id 17592186057363}
  {:db/id 17592186057366}
  {:db/id 17592186057367}
  ...]} ;; lots more
```

<a id="outline-container-default-option"></a>

<a id="default-option"></a>

## :default Option

<a id="text-default-option"></a>

```
[attr-name ":default" any-value]
```

The :default option specifies a value to return if an entity has no value for that attribute.

<a id="outline-container-default-example"></a>

<a id="default-example"></a>

### :default Option Example

<a id="text-default-example"></a>

The following select reports a zero :artist/endYear for Paul McCartney (`mccartney`), who is still active:

``` clojure
(d/pull db '[:artist/name [:artist/endYear :default 0]] mccartney)
```

``` clojure
=> {:artist/endYear 0, :artist/name "Paul McCartney"}
```

The default need not be of the same type as the attribute's values:

``` clojure
(d/pull db '[:artist/name [:artist/endYear :default "N/A"]] mccartney)
```

``` clojure
=> {:artist/endYear "N/A", :artist/name "Paul McCartney"}
```

<a id="outline-container-xform-option"></a>

<a id="xform-option"></a>

## :xform Option

<a id="text-xform-option"></a>

``` clojure
[attr-name ":xform" symbol]
```

The `:xform` option provides the ability to transform the value returned by pull for an attribute.

The `fn` is either a fully qualified function allowed under the `:xforms` key the appropriate edition-specific configuration file, or one of the following built-ins:

- [str](https://clojure.github.io/clojure/clojure.core-api.html#clojure.core/str)
- [keyword](https://clojure.github.io/clojure/clojure.core-api.html#clojure.core/keyword)
- [symbol](https://clojure.github.io/clojure/clojure.core-api.html#clojure.core/symbol)
- [name](https://clojure.github.io/clojure/clojure.core-api.html#clojure.core/name)
- [namespace](https://clojure.github.io/clojure/clojure.core-api.html#clojure.core/namespace)
- [clojure.edn/read-string](https://clojure.github.io/clojure/clojure.edn-api.html#clojure.edn/read-string)

To use additional xform functions in Cloud follow the instructions for adding `:xforms` to [ion-config.edn](../../../07-datomic-cloud-ions/02-ions-reference/ions-reference.md#configure). To use additional xform functions in Pro, add the fully qualified function under the `:xforms` key in `resources/datomic/extensions.edn`:

``` clojure
{:xforms [namespace/fn-name ...]}
```

The `fn` takes the value returned from the pull expression, which might be `nil`, and returns a value that will be included in the result instead. The return value needs to be supported by [transit](https://github.com/cognitect/transit-format) (Client API) or [fressian](https://github.com/Datomic/fressian/wiki) (Peer API) without any extension handlers.

[`:default`](#default-option) values are not transformed by `:xform`, and the `:xform` result takes precedence.

[`cancel`](../../02-transactions/03-processing-transactions/processing-transactions.md) can be used to cancel xform functions and throw `ex-info` to the caller.

<a id="outline-container-xform-example"></a>

<a id="xform-example"></a>

### :xform Option Example

<a id="text-xform-example"></a>

The following example uses the unqualified symbol `str` (from the default functions) to transform the result of pulling the `:artist/endYear` for led-zeppelin from an integer to a string:

``` clojure
(d/pull db '[[:artist/endYear :xform str]] led-zeppelin)
```

``` clojure
=> {:artist/endYear "1980"}
```

<a id="outline-container-wildcard-specifications"></a>

<a id="wildcard-specifications"></a>

## Wildcards

<a id="text-wildcard-specifications"></a>

```
wildcard           = '*'
```

The wildcard specification `*` pulls all attributes of an entity, and recursively pulls any [component attributes](#component-defaults).

<a id="outline-container-wildcard-example"></a>

<a id="wildcard-example"></a>

### Wildcard Example

<a id="text-wildcard-example"></a>

The wildcard pulls all the direct attributes of the release. It also recursively pulls `:release/media` because it is a component attribute. It does not recursively pull `:release/artists` or `:release/country`, because those are *not* component attributes.

``` clojure
(d/pull db '[*] concert-for-bangla-desh)
```

``` clojure
=>
{:release/name "The Concert for Bangla Desh",
 :release/artists [{:db/id 17592186049854}],
 :release/country {:db/id 17592186045504},
 :release/gid #uuid "f3bdff34-9a85-4adc-a014-922eef9cdaa5",
 :release/day 20,
 :release/status "Official",
 :release/month 12,
 :release/artistCredit "George Harrison",
 :db/id 17592186072003,
 :release/year 1971,
 :release/media
 [{:db/id 17592186072004,
   :medium/format {:db/id 17592186045741},
   :medium/position 1,
   :medium/trackCount 2,
   :medium/tracks
   [{:db/id 17592186072005,
     :track/duration 376000,
     :track/name "George Harrison / Ravi Shankar Introduction",
     :track/position 1,
     :track/artists [{:db/id 17592186048829} {:db/id 17592186049854}]}
    {:db/id 17592186072006,
     :track/duration 979000,
     :track/name "Bangla Dhun",
     :track/position 2,
     :track/artists [{:db/id 17592186048829}]}]}
  ...
  ]}
```

<a id="outline-container-combining-wildcards-and-map-specifications"></a>

<a id="combining-wildcards-and-map-specifications"></a>

### Combining Wildcards and Map Specifications

<a id="text-combining-wildcards-and-map-specifications"></a>

A map specification can be used in conjunction with the wildcard to provide subpatterns for specific attributes.

<a id="outline-container-combining-wildcards-and-map-specifications-example"></a>

<a id="combining-wildcards-and-map-specifications-example"></a>

#### Combining Wildcards and Map Specifications Example

<a id="text-combining-wildcards-and-map-specifications-example"></a>

The wildcard pulls all attributes of the `ghost-riders` track, and an explicit map uses the value of `:track/artists` to pull `:artist/name`.

``` clojure
(d/pull db '[* {:track/artists [:artist/name]}] ghost-riders)
```

``` clojure
=>
{:db/id 17592186063810,
 :track/duration 218506,
 :track/name "Ghost Riders in the Sky",
 :track/position 11,
 :track/artists
 [{:artist/name "Bob Dylan"} {:artist/name "George Harrison"}]}
```

<a id="outline-container-recursive-specifications"></a>

<a id="recursive-specifications"></a>

## Recursion Limits

<a id="text-recursive-specifications"></a>

```
recursion-limit    = positive-number | '...'
map-spec           = { ((attr-name | limit-expr) (pattern | recursion-limit))+ }
```

You can provide a positive number in a map specification to limit how deeply Pull should recur when encountering recursive references. You can optionally provide an ellipsis (…) instead of a number allow recursion to arbitrary depth.

If a recursive subselect encounters an entity that it has already seen, it will not apply the pattern, instead returning only the `:db/id` of the entity. Thus recursive select is safe in the presence of cycles.

<a id="outline-container-limited-recursion-example"></a>

<a id="limited-recursion-example"></a>

### Limited Recursion Example

<a id="text-limited-recursion-example"></a>

The following (non-mbrainz) specification will pull the first and last names of friends-of-friends up to six degrees of separation from the original entity.

``` clojure
[:person/firstName :person/lastName {:person/friends 6}]
```

<a id="outline-container-unlimited-recursion-example"></a>

<a id="unlimited-recursion-example"></a>

### Unlimited Recursion Example

<a id="text-unlimited-recursion-example"></a>

The following specification will find all reachable friends, which might be most of the friends in the entire database.

``` clojure
[:person/firstName :person/lastName {:person/friends ...}]
```

<a id="outline-container-empty-results"></a>

<a id="empty-results"></a>

### Empty Results

<a id="text-empty-results"></a>

If there is no match between a pattern and an entity, then `pull` will return an empty map:

``` clojure
(d/pull db '[:penguins] led-zeppelin)
```

``` clojure
=> {}
```

Non-matching results will be removed entirely from the return map. Even though `ghost-riders` has artists, none of those artists have `:penguins`:

``` clojure
(d/pull db '[{:track/artists [:penguins]}] ghost-riders)
```

``` clojure
=> {:track/artists []}
```

<a id="outline-container-pull-results"></a>

<a id="pull-results"></a>

## Pull Results

<a id="text-pull-results"></a>

<a id="outline-container-component-defaults"></a>

<a id="component-defaults"></a>

### Component Defaults

<a id="text-component-defaults"></a>

If a pull `attr-name` names a reference attribute, `pull` will return a map for the referenced value. If the attribute is a [component attribute](#component-defaults), the return map will contain all attributes of the related entity as well.

<a id="outline-container-component-defaults-example"></a>

<a id="component-defaults-example"></a>

#### Component Defaults Example

<a id="text-component-defaults-example"></a>

`:medium/tracks` is a component attribute, so pulling `:release/media` will also pull related tracks. The example below pulls from `dark-side-of-the-moon`.

``` clojure
(d/pull db [:release/media] dark-side-of-the-moon)
```

``` clojure
=>
{:release/media
 [{:db/id 17592186121277,
   :medium/format {:db/id 17592186045741},
   :medium/position 1,
   :medium/trackCount 10,
   :medium/tracks
   [{:db/id 17592186121278,
     :track/duration 68346,
     :track/name "Speak to Me",
     :track/position 1,
     :track/artists [{:db/id 17592186046909}]}
    {:db/id 17592186121279,
     :track/duration 168720,
     :track/name "Breathe",
     :track/position 2,
     :track/artists [{:db/id 17592186046909}]}
    {:db/id 17592186121280,
     :track/duration 230600,
     :track/name "On the Run",
     :track/position 3,
     :track/artists [{:db/id 17592186046909}]}
    ...]}]}
```

<a id="outline-container-non-component-defaults"></a>

<a id="non-component-defaults"></a>

### Non-Component Defaults

<a id="text-non-component-defaults"></a>

If a reference is to a non-component attribute, the default is to pull only the `:db/id`.

<a id="outline-container-non-component-defaults-example"></a>

<a id="non-component-defaults-example"></a>

#### Non-Component Defaults Example

<a id="text-non-component-defaults-example"></a>

Pulling `:artist/_{country}` of `:country/GB` returns only the entity ids for the artists from Great Britain:

``` clojure
(d/pull db '[:artist/_country] :country/GB)
```

``` clojure
=> {:artist/_country [{:db/id 17592186045751} {:db/id 17592186045755} ...]}
```

<a id="outline-container-multiple-results"></a>

<a id="multiple-results"></a>

### Multiple Results

<a id="text-multiple-results"></a>

If navigating an attribute might lead to more than one value, the pull result will be a list of the values found. These cases include:

- All forward cardinality-many references
- Reverse references for non-component attributes.

<a id="outline-container-multiple-results-example"></a>

<a id="multiple-results-example"></a>

#### Multiple Results Example

<a id="text-multiple-results-example"></a>

Pulling `[:release/media]` of `dark-side-of-the-moon` pulls the values associated with `[:release/media]` and from inside of those results.

``` clojure
(d/pull db '[:release/media] dark-side-of-the-moon)
```

``` clojure
=> 
{:release/media [{:db/id         23485568369468073
                  :medium/tracks [{:db/id         23485568369468074
                                   :track/artists [{:db/id 22940210601927955}]
                                   ...}]
                  ...}]}
```

<a id="outline-container-missing-attributes"></a>

<a id="missing-attributes"></a>

### Missing Attributes

<a id="text-missing-attributes"></a>

In the absence of a default, attribute specifications that do not match an entity are omitted from that entity's result map, rather than e.g. appearing with a `nil` value.

<a id="outline-container-missing-attributes-example"></a>

<a id="missing-attributes-example"></a>

#### Missing Attributes Example

<a id="text-missing-attributes-example"></a>

Paul McCartney has an `:artist/name` but not a `died-in-1966`, so only the former appears in a pull result:

``` clojure
(d/pull db '[:artist/name :died-in-1966?] mccartney)
```

``` clojure
=> {:artist/name "Paul McCartney"}
```

<a id="outline-container-attribute-expressions"></a>

<a id="attribute-expressions"></a>

## Legacy Attribute Expressions

<a id="text-attribute-expressions"></a>

> NOTE: [Attributes Specifications](#attribute-with-options) provides a superset of the functionality of Attribute Expressions and is preferred, however `limit` and `default` Attribute Expressions will continue to be supported.

```
attr-expr           = [attr-name attr-option+] | legacy-attr-expr
legacy-attr-expr    = legacy-limit-expr | legacy-default-expr
legacy-limit-expr   = [("limit" | 'limit') attr-name (positive-number | nil)]
legacy-default-expr = [("default" | 'default') attr-name any-value]
```

Attribute specifications can be wrapped in expressions to control the attribute's default or limit. Each is shown below.

<a id="outline-container-limit-expression"></a>

<a id="limit-expression"></a>

## Legacy Limit Expression

<a id="text-limit-expression"></a>

```
legacy-limit-expr   = [("limit" | 'limit') attr-name (positive-number | nil)]
```

The legacy limit expression is an alternate syntax for [Limit Option](#limit-option). Limit Option is preferred.

<a id="outline-container-default-expressions"></a>

<a id="default-expressions"></a>

## Legacy Default Expressions

<a id="text-default-expressions"></a>

```
legacy-default-expr = [("default" | 'default') attr-name any-value]
```

The legacy default expression is an alternate syntax for [Default Option](#default-option). Default Option is preferred.
