# Tick

Tick is a Clojure, ClojureScript, and Babashka library for working with time. It provides a concise API over `java.time` on the JVM and `js-joda` on JavaScript runtimes.

- Read the generated [`API.md`](API.md) for namespace and var documentation.
- The upstream `juxt/tick` repository has comprehensive documentation in `docs/`. Use the `local-git-reference` skill to find the local checkout and consult those docs when this reference is not enough.
- When Tick does not expose a `java.time` API you need, use the underlying [`cljc.java-time`](https://github.com/henryw374/cljc.java-time) library. It mirrors the `java.time` API and underpins Tick. Treat direct `java.time` interop as a last resort.

## Top tips

### `java.time`

In both Clojure and Clojurescript versions, tick is just calling through to java.time methods. Understanding [the main entities of java.time](https://docs.oracle.com/javase/tutorial/datetime/iso/overview.html) is necessary to use tick. For example, one should know that there are 2 separate ways to measure amounts of time (Period and Duration), 3 ways to represent a point on the timeline (Instant, ZonedDateTime & OffsetDateTime) and so on.

### Instants

Instants are not 'calendar-aware' - they just contain millis+nanos fields representing an offset from the Unix epoch. This means Instants have no method to get their year or month for example, because to do so would require a calendar (e.g. the [Gregorian calendar](https://en.wikipedia.org/wiki/Gregorian_calendar)).

However, the following does work in Tick: `(t/year (t/instant))`. To make that possible, tick first converts the Instant into a ZonedDateTime (which does have a calendar). Take note however that the zone of the ZonedDateTime will be the browser's or jvm's timezone. To be explicit about the zone required do this:

```clojure
(-> (t/instant)
    (t/in "UTC")
    (t/year))
```

The other cases where calendar-awareness might come up is when formatting Instants to string or when shifting them by e.g. years/months, so Tick [shows explanatory error messages in that case](https://widdindustries.com/why-not-interop/).

### Singular vs Plural ?

As with java.time, any functions working with amounts of time (ie Durations or Periods), will have names which are in the plural. Functions that work with dates and times are singular. Knowing that, e.g. `t/second` vs `t/seconds` makes sense.

---

# Need to know 

* a `temporal` is an entity that relates to the timeline (LocalDate, Instant, ZonedDateTime etc)
* a `temporal-amount` is an entity representing a quantity of time - either a Duration or a Period
* a basic understanding of [the main entities of java.time](https://github.com/juxt/tick#javatime) is required to use tick
* Where tick doesn’t provide the API you need, drop to [cljc.java-time](https://github.com/henryw374/cljc.java-time)

# Naming (compared to java.time)

* LocalDate => `date`
* LocalDateTime => `date-time`
* LocalTime => `time`
* java.util.Date => `inst` 
* js/Date => `inst`

otherwise all camel-case equivalents of java.time names

# Temporals

All functions relating to `temporals` have names in the singular, whereas functions relating to `temporal-amounts` have names in the plural, e.g. `(t/hour x)` vs `(t/hours x)`

## Construction

### Now

zero-arity function for the required type 

```clojure
(t/date), (t/zoned-date-time), (t/instant), (t/...)
```

Temporarily change what clock is used to get the `now` or `where` information with `with-clock`

```clojure
(t/with-clock
  (t/zoned-date-time "2023-08-23T20:00-10:00[Pacific/Honolulu]") 
   (t/date)) 
 ; => returns (t/date "2023-08-23")
```

### Extraction / Conversion

```clojure
(t/date (t/zoned-date-time))
(t/hour (t/zoned-date-time))
(t/inst (t/zoned-date-time))
```

set hours and smaller to zero
```clojure
(t/truncate (t/instant) :hours) 
```

### Combining parts

```clojure
(-> (t/date)
    (t/at "00:00")
    (t/in "UTC"))

(-> (t/time "10:10")
    (t/on (t/date)))

; 'set' or 'adjust' a specific field
(t/with (t/date) (t/year 3030))
```

### from/to Strings 

ISO-formatted

```clojure

(t/instant "2020-02-02T00:00:00Z")
(t/... "2020...")

(str (t/instant))

```

Custom formats

```clojure
(t/parse-... "2021-...", (t/formatter "pattern"))

(t/format (t/formatter "pattern") (t/date))
```

### from numbers 

```clojure
(t/new-date 2020 2 2) 
(t/new-... )
```
round-trip to/from epoch millis
```clojure
(-> (t/instant) (cljc.java-time.instant/to-epoch-milli) (t/instant))
```

### Relative temporals aka `shifting`

```clojure
 (t/>> (t/instant) (t/of-hours 2))
 (t/<< ...)
```

# Temporal Amounts

## Construction

```clojure
(t/of-hours 24) => Duration
(t/of-days 1) => Period
(t/of-..)
```

### From temporals

```clojure
(t/between a b) ;=> returns temporal-amount
(t/between a b :days) ;=> returns number
```

## Arithmetic

```clojure
(t/+ (t/of-minutes 5) (t/of-minutes 5) (t/of-minutes 5), ...)
(t/- ...)
```

## Extract parts

function names in plural

```clojure
(t/millis ...)
(t/days ...)
```

# Comparison

```clojure
t/<, t/<=, t/=, ...
t/max, t/max-by, t/min, t/min-by
```

## contains/coincidence

```clojure 
(t/coincident? temporal-start temporal-end a-temporal))
```

# Type Predicates 

```clojure
(t/date-time? x)
(t/...? x)
```

# Units

```clojure
t/APRIL,
t/DECEMBER ...

t/FRIDAY, t/MONDAY...

(keys t/unit-map) => :nanos :days :seconds ...

```


