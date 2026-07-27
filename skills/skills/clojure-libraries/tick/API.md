# Table of contents
-  [`tick.alpha.calendar`](#tick.alpha.calendar) 
    -  [`bank-holidays-in-england-and-wales`](#tick.alpha.calendar/bank-holidays-in-england-and-wales)
    -  [`select-by-year`](#tick.alpha.calendar/select-by-year) - Given the sequence of holidays (which must be intervals, such as iCalendar VEvent objects), select only those of a given year.
    -  [`weekend?`](#tick.alpha.calendar/weekend?) - Is the ZonedDateTime during the weekend?.
-  [`tick.alpha.ical`](#tick.alpha.ical) 
    -  [`ALPHA-DIGIT`](#tick.alpha.ical/alpha-digit)
    -  [`CONTROL`](#tick.alpha.ical/control)
    -  [`CRLF`](#tick.alpha.ical/crlf)
    -  [`DATE-TIME-FORM-1-PATTERN`](#tick.alpha.ical/date-time-form-1-pattern)
    -  [`DATE-TIME-FORM-2-PATTERN`](#tick.alpha.ical/date-time-form-2-pattern)
    -  [`DATE-TIME-FORM-3-PATTERN`](#tick.alpha.ical/date-time-form-3-pattern)
    -  [`ICalendarObject`](#tick.alpha.ical/icalendarobject)
    -  [`ICalendarValue`](#tick.alpha.ical/icalendarvalue)
    -  [`IPrintable`](#tick.alpha.ical/iprintable)
    -  [`QSAFE-CHAR`](#tick.alpha.ical/qsafe-char)
    -  [`SAFE-CHAR`](#tick.alpha.ical/safe-char)
    -  [`VALUE-CHAR`](#tick.alpha.ical/value-char)
    -  [`add-contentline-to-model`](#tick.alpha.ical/add-contentline-to-model) - A reducing function that gives a parsed content-line to an accumulator that builds a model.
    -  [`add-property`](#tick.alpha.ical/add-property)
    -  [`char-range`](#tick.alpha.ical/char-range)
    -  [`coerce-to-value`](#tick.alpha.ical/coerce-to-value)
    -  [`contentline`](#tick.alpha.ical/contentline) - Fold the given string value returning a sequence of strings up to 75 octets in length, as per RFC 5545 folding rules.
    -  [`error`](#tick.alpha.ical/error)
    -  [`events`](#tick.alpha.ical/events) - Given a vcalendar object, return only the events.
    -  [`extract-name-as-string`](#tick.alpha.ical/extract-name-as-string)
    -  [`extract-param-value-as-string`](#tick.alpha.ical/extract-param-value-as-string)
    -  [`line->contentline`](#tick.alpha.ical/line->contentline)
    -  [`parse-ical`](#tick.alpha.ical/parse-ical)
    -  [`print-cl`](#tick.alpha.ical/print-cl) - Folding print, where long lines are folded as per RFC 5545 Section 4.1.
    -  [`print-object`](#tick.alpha.ical/print-object) - Print as an iCalendar object.
    -  [`print-property`](#tick.alpha.ical/print-property)
    -  [`property-value`](#tick.alpha.ical/property-value) - Return the first property value of an ICalendarObject.
    -  [`property-values`](#tick.alpha.ical/property-values) - Return the properties of an ICalendarObject with the given name.
    -  [`serialize-value`](#tick.alpha.ical/serialize-value)
    -  [`unfolding-line-seq`](#tick.alpha.ical/unfolding-line-seq)
    -  [`unfolding-line-seq*`](#tick.alpha.ical/unfolding-line-seq*)
    -  [`wrap-with`](#tick.alpha.ical/wrap-with)
-  [`tick.alpha.interval`](#tick.alpha.interval) 
    -  [`->GeneralRelation`](#tick.alpha.interval/->generalrelation)
    -  [`GeneralRelation`](#tick.alpha.interval/generalrelation)
    -  [`IDivisibleInterval`](#tick.alpha.interval/idivisibleinterval)
    -  [`IGroupable`](#tick.alpha.interval/igroupable)
    -  [`IIntervalOps`](#tick.alpha.interval/iintervalops)
    -  [`am`](#tick.alpha.interval/am)
    -  [`basic-relation`](#tick.alpha.interval/basic-relation) - A function to determine the (basic) relation between two intervals.
    -  [`basic-relations`](#tick.alpha.interval/basic-relations)
    -  [`bounds`](#tick.alpha.interval/bounds)
    -  [`complement`](#tick.alpha.interval/complement)
    -  [`complement-r`](#tick.alpha.interval/complement-r) - Return the complement of the general relation.
    -  [`compose-r`](#tick.alpha.interval/compose-r) - Return the composition of r and s.
    -  [`concur`](#tick.alpha.interval/concur) - Return the interval representing the interval, if there is one, representing the interval of time the given intervals are concurrent.
    -  [`concur?`](#tick.alpha.interval/concur?)
    -  [`concurrencies`](#tick.alpha.interval/concurrencies) - Return a sequence of occurances where intervals coincide (having non-nil concur intervals).
    -  [`conj`](#tick.alpha.interval/conj)
    -  [`contains?`](#tick.alpha.interval/contains?)
    -  [`conv`](#tick.alpha.interval/conv) - The converse of a basic relation.
    -  [`converse-r`](#tick.alpha.interval/converse-r) - Return the converse of the given general relation.
    -  [`difference`](#tick.alpha.interval/difference) - Return an interval set that is the first set without elements of the remaining sets.
    -  [`disjoin`](#tick.alpha.interval/disjoin) - Split s1 across the grating defined by s2.
    -  [`disjoint?`](#tick.alpha.interval/disjoint?)
    -  [`divide`](#tick.alpha.interval/divide)
    -  [`divide-by`](#tick.alpha.interval/divide-by)
    -  [`divide-by-divisor`](#tick.alpha.interval/divide-by-divisor) - Divides the interval specified by <code>ival</code> into <code>divisor</code> spaced intervals.
    -  [`divide-by-duration`](#tick.alpha.interval/divide-by-duration) - Divide an interval by a duration, returning a sequence of intervals.
    -  [`divide-by-period`](#tick.alpha.interval/divide-by-period)
    -  [`divide-interval`](#tick.alpha.interval/divide-interval) - Divide an interval by a given divisor.
    -  [`during?`](#tick.alpha.interval/during?)
    -  [`equals?`](#tick.alpha.interval/equals?)
    -  [`extend`](#tick.alpha.interval/extend)
    -  [`finished-by?`](#tick.alpha.interval/finished-by?)
    -  [`finishes?`](#tick.alpha.interval/finishes?)
    -  [`flatten`](#tick.alpha.interval/flatten)
    -  [`group-by`](#tick.alpha.interval/group-by)
    -  [`group-by-intervals`](#tick.alpha.interval/group-by-intervals) - Divide intervals in s1 by (disjoint ordered) intervals in s2, splitting if necessary, grouping by s2.
    -  [`intersection`](#tick.alpha.interval/intersection) - Return a time-ordered sequence of disjoint intervals where two or more intervals of the given sequences are concurrent.
    -  [`intersection-r`](#tick.alpha.interval/intersection-r) - Return the intersection of the r with s.
    -  [`intersects?`](#tick.alpha.interval/intersects?)
    -  [`interval`](#tick.alpha.interval/interval)
    -  [`map->GeneralRelation`](#tick.alpha.interval/map->generalrelation)
    -  [`meets?`](#tick.alpha.interval/meets?)
    -  [`met-by?`](#tick.alpha.interval/met-by?)
    -  [`new-interval`](#tick.alpha.interval/new-interval)
    -  [`new-interval-group`](#tick.alpha.interval/new-interval-group) - Return an interval group.
    -  [`new-relation`](#tick.alpha.interval/new-relation)
    -  [`normalize`](#tick.alpha.interval/normalize) - Within a time-ordered sequence of disjoint intervals, return a sequence of interval groups, splicing together meeting intervals.
    -  [`not-yet-implemented`](#tick.alpha.interval/not-yet-implemented)
    -  [`ordered-disjoint-intervals?`](#tick.alpha.interval/ordered-disjoint-intervals?) - Are all the intervals in the given set time-ordered and disjoint? This is a useful property of a collection of intervals.
    -  [`overlapped-by?`](#tick.alpha.interval/overlapped-by?)
    -  [`overlaps?`](#tick.alpha.interval/overlaps?)
    -  [`pm`](#tick.alpha.interval/pm)
    -  [`preceded-by?`](#tick.alpha.interval/preceded-by?)
    -  [`precedes-or-meets?`](#tick.alpha.interval/precedes-or-meets?)
    -  [`precedes?`](#tick.alpha.interval/precedes?)
    -  [`relation`](#tick.alpha.interval/relation)
    -  [`relation->kw`](#tick.alpha.interval/relation->kw)
    -  [`scale`](#tick.alpha.interval/scale)
    -  [`slice`](#tick.alpha.interval/slice) - Fit the interval between beginning and end, slicing off one or both ends as necessary.
    -  [`slice-interval`](#tick.alpha.interval/slice-interval)
    -  [`splice`](#tick.alpha.interval/splice) - Splice another interval on to this one.
    -  [`split`](#tick.alpha.interval/split) - Split ival into 2 intervals at t, returned as a 2-element vector.
    -  [`split-interval`](#tick.alpha.interval/split-interval)
    -  [`split-with-assert`](#tick.alpha.interval/split-with-assert)
    -  [`started-by?`](#tick.alpha.interval/started-by?)
    -  [`starts?`](#tick.alpha.interval/starts?)
    -  [`union`](#tick.alpha.interval/union) - Merge multiple time-ordered sequences of disjoint intervals into a single sequence of time-ordered disjoint intervals.
    -  [`unite`](#tick.alpha.interval/unite) - Unite concurrent intervals.
-  [`tick.core`](#tick.core) 
    -  [`*clock*`](#tick.core/*clock*)
    -  [`*time-literals-printing*`](#tick.core/*time-literals-printing*) - If true, include the time-literals printer, which will affect the way java.time and js-joda objects are printed.
    -  [`+`](#tick.core/+) - Sum amounts of time.
    -  [`-`](#tick.core/-) - Subtract amounts of time.
    -  [`->AtomicClock`](#tick.core/->atomicclock)
    -  [`->FieldsLookup`](#tick.core/->fieldslookup)
    -  [`<`](#tick.core/<) - Same as clojure.core/<, but works on dates, rather than numbers.
    -  [`<<`](#tick.core/<<) - shift Temporal backward.
    -  [`<=`](#tick.core/<=) - Same as clojure.core/<=, but works on dates, rather than numbers.
    -  [`=`](#tick.core/=) - Same as clojure.core/=, but works on dates, rather than numbers.
    -  [`>`](#tick.core/>) - Same as clojure.core/>, but works on dates, rather than numbers.
    -  [`>=`](#tick.core/>=) - Same as clojure.core/>=, but works on dates, rather than numbers.
    -  [`>>`](#tick.core/>>) - shift Temporal forward.
    -  [`APRIL`](#tick.core/april)
    -  [`AUGUST`](#tick.core/august)
    -  [`AtomicClock`](#tick.core/atomicclock)
    -  [`DECEMBER`](#tick.core/december)
    -  [`FEBRUARY`](#tick.core/february)
    -  [`FRIDAY`](#tick.core/friday)
    -  [`FieldsLookup`](#tick.core/fieldslookup)
    -  [`JANUARY`](#tick.core/january)
    -  [`JULY`](#tick.core/july)
    -  [`JUNE`](#tick.core/june)
    -  [`MARCH`](#tick.core/march)
    -  [`MAY`](#tick.core/may)
    -  [`MONDAY`](#tick.core/monday)
    -  [`NOVEMBER`](#tick.core/november)
    -  [`OCTOBER`](#tick.core/october)
    -  [`SATURDAY`](#tick.core/saturday)
    -  [`SEPTEMBER`](#tick.core/september)
    -  [`SUNDAY`](#tick.core/sunday)
    -  [`THURSDAY`](#tick.core/thursday)
    -  [`TUESDAY`](#tick.core/tuesday)
    -  [`UTC`](#tick.core/utc)
    -  [`WEDNESDAY`](#tick.core/wednesday)
    -  [`ago`](#tick.core/ago) - current instant shifted back by duration 'dur'.
    -  [`at`](#tick.core/at) - Set date to be AT a time.
    -  [`atom`](#tick.core/atom) - construct atomic clock.
    -  [`backward-compatible-time-span-extensions`](#tick.core/backward-compatible-time-span-extensions) - pre v0.7, ITimeSpan was extended as per this body.
    -  [`beginning`](#tick.core/beginning) - the beginning of the range of ITimeSpan v or v.
    -  [`between`](#tick.core/between) - for the 2-arity version, find the temporal-amount between v1 and v2, or for the 3-arity version the amount of 'unit' between v1 and v2.
    -  [`clock`](#tick.core/clock) - return i as a clock.
    -  [`clock?`](#tick.core/clock?) - true if v is a clock?.
    -  [`coincident?`](#tick.core/coincident?) - for the 2-arity ver, Does containing-interval wholly contain the given contained-interval? for the 3-arity, does the event lie within the span of time described by start and end.
    -  [`compare-and-set!`](#tick.core/compare-and-set!) - cas on atomic clock 'at'.
    -  [`current-clock`](#tick.core/current-clock)
    -  [`current-zone`](#tick.core/current-zone) - Return the current zone, which can be overridden by the *clock* dynamic var.
    -  [`date`](#tick.core/date)
    -  [`date-time`](#tick.core/date-time)
    -  [`date-time?`](#tick.core/date-time?) - true if v is a date-time?.
    -  [`date?`](#tick.core/date?) - true if v is a date?.
    -  [`day-of-month`](#tick.core/day-of-month) - extract day-of-month from v.
    -  [`day-of-week`](#tick.core/day-of-week) - extract day-of-week from v.
    -  [`day-of-week-in-month`](#tick.core/day-of-week-in-month)
    -  [`day-of-week?`](#tick.core/day-of-week?) - true if v is a day-of-week?.
    -  [`days`](#tick.core/days) - extract days from 'v'.
    -  [`dec`](#tick.core/dec)
    -  [`divide`](#tick.core/divide) - divide TemporalAmount t by divisor, which is a unit e.g.
    -  [`duration`](#tick.core/duration) - return Duration or Period (whichever appropriate based on type) contained within the range of ITimeSpan x.
    -  [`duration?`](#tick.core/duration?) - true if v is a duration?.
    -  [`end`](#tick.core/end) - the end of the range of ITimeSpan v or v.
    -  [`epoch`](#tick.core/epoch) - Constant for the 1970-01-01T00:00:00Z epoch instant.
    -  [`field-map`](#tick.core/field-map) - keyword to chrono-field.
    -  [`fields`](#tick.core/fields)
    -  [`first-day-of-month`](#tick.core/first-day-of-month)
    -  [`first-day-of-next-month`](#tick.core/first-day-of-next-month)
    -  [`first-day-of-next-year`](#tick.core/first-day-of-next-year)
    -  [`first-day-of-year`](#tick.core/first-day-of-year)
    -  [`first-in-month`](#tick.core/first-in-month)
    -  [`format`](#tick.core/format) - Formats the given time entity as a string.
    -  [`formatter`](#tick.core/formatter) - Constructs a DateTimeFormatter out of either a * format string - "yyyy/MM/dd" "yyy HH:mm" etc.
    -  [`greater`](#tick.core/greater) - the greater of x and y.
    -  [`hence`](#tick.core/hence) - current instant shifted forward by duration 'dur'.
    -  [`hour`](#tick.core/hour) - extract hour from t.
    -  [`hours`](#tick.core/hours) - extract hours from 'v'.
    -  [`in`](#tick.core/in) - Set a date-time to be in a time-zone.
    -  [`inc`](#tick.core/inc)
    -  [`inst`](#tick.core/inst)
    -  [`instant`](#tick.core/instant)
    -  [`instant?`](#tick.core/instant?) - true if v is a instant?.
    -  [`int`](#tick.core/int)
    -  [`interval?`](#tick.core/interval?) - true if v is a interval?.
    -  [`last-day-of-month`](#tick.core/last-day-of-month)
    -  [`last-day-of-year`](#tick.core/last-day-of-year)
    -  [`last-in-month`](#tick.core/last-in-month)
    -  [`lesser`](#tick.core/lesser) - the lesser of x and y.
    -  [`long`](#tick.core/long)
    -  [`map->AtomicClock`](#tick.core/map->atomicclock)
    -  [`max`](#tick.core/max) - Find the latest of the given arguments.
    -  [`max-key`](#tick.core/max-key) - Same as clojure.core/max-key, but works on dates, rather than numbers.
    -  [`max-of-type`](#tick.core/max-of-type) - return e.g Instant/MAX given and Instant.
    -  [`micros`](#tick.core/micros) - extract micros from 'v'.
    -  [`microsecond`](#tick.core/microsecond) - extract microsecond from t.
    -  [`midnight`](#tick.core/midnight)
    -  [`midnight?`](#tick.core/midnight?)
    -  [`millis`](#tick.core/millis) - extract millis from 'v'.
    -  [`millisecond`](#tick.core/millisecond) - extract millisecond from t.
    -  [`min`](#tick.core/min) - Find the earliest of the given arguments.
    -  [`min-key`](#tick.core/min-key) - Same as clojure.core/min-key, but works on dates, rather than numbers.
    -  [`min-of-type`](#tick.core/min-of-type) - return e.g Instant/MIN given and Instant.
    -  [`minute`](#tick.core/minute) - extract minute from t.
    -  [`minutes`](#tick.core/minutes) - extract minutes from 'v'.
    -  [`modify-printing-of-time-literals-if-enabled!`](#tick.core/modify-printing-of-time-literals-if-enabled!)
    -  [`month`](#tick.core/month) - extract month from v.
    -  [`month?`](#tick.core/month?) - true if v is a month?.
    -  [`months`](#tick.core/months) - extract months from 'v'.
    -  [`nanos`](#tick.core/nanos) - extract nanos from 'v'.
    -  [`nanosecond`](#tick.core/nanosecond) - extract nanosecond from t.
    -  [`negated`](#tick.core/negated) - Return the duration as a negative duration.
    -  [`new-date`](#tick.core/new-date)
    -  [`new-duration`](#tick.core/new-duration)
    -  [`new-period`](#tick.core/new-period)
    -  [`new-time`](#tick.core/new-time)
    -  [`new-year-month`](#tick.core/new-year-month)
    -  [`next`](#tick.core/next)
    -  [`next-or-same`](#tick.core/next-or-same)
    -  [`noon`](#tick.core/noon)
    -  [`now`](#tick.core/now) - same as (t/instant).
    -  [`of-days`](#tick.core/of-days) - Takes a java.lang.Long n and returns a period of n days.
    -  [`of-hours`](#tick.core/of-hours) - Takes a java.lang.Long n and returns a duration of n hours.
    -  [`of-micros`](#tick.core/of-micros) - Takes a java.lang.Long n and returns a duration of n micros.
    -  [`of-millis`](#tick.core/of-millis) - Takes a java.lang.Long n and returns a duration of n micros.
    -  [`of-minutes`](#tick.core/of-minutes) - Takes a java.lang.Long n and returns a duration of n minutes.
    -  [`of-months`](#tick.core/of-months) - Takes a java.lang.Long n and returns a period of n months.
    -  [`of-nanos`](#tick.core/of-nanos) - Takes a java.lang.Long n and returns a duration of n nanoseconds.
    -  [`of-seconds`](#tick.core/of-seconds) - Takes a java.lang.Long n and returns a duration of n seconds.
    -  [`of-years`](#tick.core/of-years) - Takes a java.lang.Long n and returns a period of n years.
    -  [`offset-by`](#tick.core/offset-by) - Set a date-time to be offset by an amount.
    -  [`offset-date-time`](#tick.core/offset-date-time)
    -  [`offset-date-time?`](#tick.core/offset-date-time?) - true if v is a offset-date-time?.
    -  [`on`](#tick.core/on) - Set time be ON a date.
    -  [`parse-date`](#tick.core/parse-date) - to parse an iso-formatted date, use (t/date "2020..") instead.
    -  [`parse-date-time`](#tick.core/parse-date-time) - to parse an iso-formatted date-time, use (t/date-time "2020..") instead.
    -  [`parse-day`](#tick.core/parse-day) - en locale specific and borderline deprecated.
    -  [`parse-month`](#tick.core/parse-month) - en locale specific and borderline deprecated.
    -  [`parse-offset-date-time`](#tick.core/parse-offset-date-time) - to parse an iso-formatted offset-date-time, use (t/offset-date-time "2020..") instead.
    -  [`parse-time`](#tick.core/parse-time) - to parse an iso-formatted time, use (t/time "20:20..") instead.
    -  [`parse-year`](#tick.core/parse-year) - to parse an iso-formatted year, use (t/year "2020") instead.
    -  [`parse-year-month`](#tick.core/parse-year-month) - to parse an iso-formatted year-month, use (t/year-month "2020..") instead.
    -  [`parse-zoned-date-time`](#tick.core/parse-zoned-date-time) - to parse an iso-formatted zoned-date-time, use (t/zoned-date-time "2020..") instead.
    -  [`period?`](#tick.core/period?) - true if v is a period?.
    -  [`predefined-formatters`](#tick.core/predefined-formatters)
    -  [`previous`](#tick.core/previous)
    -  [`previous-or-same`](#tick.core/previous-or-same)
    -  [`range`](#tick.core/range) - Returns a lazy seq of times from start (inclusive) to end (exclusive, nil means forever), by step, where start defaults to 0, step to 1, and end to infinity.
    -  [`reset!`](#tick.core/reset!) - reset! on atomic clock 'at'.
    -  [`reset-vals!`](#tick.core/reset-vals!) - reset-vals! on atomic clock 'at'.
    -  [`reverse-unit-map`](#tick.core/reverse-unit-map)
    -  [`second`](#tick.core/second) - extract second from t.
    -  [`seconds`](#tick.core/seconds) - extract seconds from 'v'.
    -  [`swap!`](#tick.core/swap!) - swap! on atomic clock 'at'.
    -  [`swap-vals!`](#tick.core/swap-vals!) - swap-vals! on atomic clock 'at'.
    -  [`tick-resolution`](#tick.core/tick-resolution) - Obtains a clock that returns instants from the specified clock truncated to the nearest occurrence of the specified duration.
    -  [`time`](#tick.core/time) - extract time from v.
    -  [`time?`](#tick.core/time?) - true if v is a time?.
    -  [`today`](#tick.core/today) - same as (t/date).
    -  [`tomorrow`](#tick.core/tomorrow)
    -  [`truncate`](#tick.core/truncate) - Returns a copy of x truncated to the specified unit.
    -  [`unit-map`](#tick.core/unit-map) - keyword to chrono-unit.
    -  [`units`](#tick.core/units) - the units contained within TemporalAmount x.
    -  [`with`](#tick.core/with) - Adjust a temporal with an adjuster or field.
    -  [`with-clock`](#tick.core/with-clock) - temporarily change ambient now+zone info the given 'clock' could be an Instant, zone or zoned-date-time.
    -  [`year`](#tick.core/year) - extract year from v.
    -  [`year-month`](#tick.core/year-month) - extract year-month from v.
    -  [`year-month?`](#tick.core/year-month?) - true if v is a year-month?.
    -  [`year?`](#tick.core/year?) - true if v is a year?.
    -  [`years`](#tick.core/years) - extract years from 'v'.
    -  [`yesterday`](#tick.core/yesterday)
    -  [`zone`](#tick.core/zone)
    -  [`zone-offset`](#tick.core/zone-offset)
    -  [`zone-offset?`](#tick.core/zone-offset?) - true if v is a zone-offset?.
    -  [`zone?`](#tick.core/zone?) - true if v is a zone?.
    -  [`zoned-date-time`](#tick.core/zoned-date-time)
    -  [`zoned-date-time?`](#tick.core/zoned-date-time?) - true if v is a zoned-date-time?.
-  [`tick.protocols`](#tick.protocols) 
    -  [`+`](#tick.protocols/+) - Sum amounts of time.
    -  [`-`](#tick.protocols/-) - Subtract from amount of time, or negate.
    -  [`<`](#tick.protocols/<) - Is x before y?.
    -  [`<=`](#tick.protocols/<=) - Is x before or at the same time as y?.
    -  [`=`](#tick.protocols/=) - Is x the same point on the timeline as y?.
    -  [`>`](#tick.protocols/>) - Is x after y?.
    -  [`>=`](#tick.protocols/>=) - Is x after or at the same time as y?.
    -  [`IBetween`](#tick.protocols/ibetween)
    -  [`IClock`](#tick.protocols/iclock)
    -  [`IConversion`](#tick.protocols/iconversion)
    -  [`IDivisible`](#tick.protocols/idivisible)
    -  [`IDivisibleDuration`](#tick.protocols/idivisibleduration)
    -  [`IExtraction`](#tick.protocols/iextraction)
    -  [`ILocalTime`](#tick.protocols/ilocaltime)
    -  [`IParseable`](#tick.protocols/iparseable)
    -  [`ITimeArithmetic`](#tick.protocols/itimearithmetic)
    -  [`ITimeComparison`](#tick.protocols/itimecomparison)
    -  [`ITimeLength`](#tick.protocols/itimelength)
    -  [`ITimeRangeable`](#tick.protocols/itimerangeable)
    -  [`ITimeReify`](#tick.protocols/itimereify)
    -  [`ITimeShift`](#tick.protocols/itimeshift)
    -  [`ITimeSpan`](#tick.protocols/itimespan)
    -  [`ITruncate`](#tick.protocols/itruncate)
    -  [`MinMax`](#tick.protocols/minmax)
    -  [`at`](#tick.protocols/at) - Set date to be AT a time.
    -  [`backward-duration`](#tick.protocols/backward-duration) - Decrement time.
    -  [`backward-number`](#tick.protocols/backward-number) - Decrement time.
    -  [`beginning`](#tick.protocols/beginning) - Return the beginning of a span of time.
    -  [`between`](#tick.protocols/between) - Return the duration (or period) between two times.
    -  [`clock`](#tick.protocols/clock) - Make a clock.
    -  [`date`](#tick.protocols/date) - Make a java.time.LocalDate instance.
    -  [`date-time`](#tick.protocols/date-time) - Make a java.time.LocalDateTime instance.
    -  [`day-of-month`](#tick.protocols/day-of-month) - Return value of the day in the month as an integer.
    -  [`day-of-week`](#tick.protocols/day-of-week) - Make a java.time.DayOfWeek instance.
    -  [`days`](#tick.protocols/days) - Return the given quantity in days.
    -  [`divide`](#tick.protocols/divide) - Divide time.
    -  [`divide-duration`](#tick.protocols/divide-duration) - Divide a duration.
    -  [`end`](#tick.protocols/end) - Return the end of a span of time.
    -  [`forward-duration`](#tick.protocols/forward-duration) - Increment time.
    -  [`forward-number`](#tick.protocols/forward-number) - Increment time.
    -  [`hour`](#tick.protocols/hour) - Return the hour field of the given time.
    -  [`hours`](#tick.protocols/hours) - Return the given quantity in hours.
    -  [`in`](#tick.protocols/in) - Set a date-time to be in a time-zone.
    -  [`inst`](#tick.protocols/inst) - Make a java.util.Date or js/Date instance.
    -  [`instant`](#tick.protocols/instant) - Make a java.time.Instant instance.
    -  [`int`](#tick.protocols/int) - Return value as integer.
    -  [`local?`](#tick.protocols/local?) - Is the time a java.time.LocalTime or java.time.LocalDateTime?.
    -  [`long`](#tick.protocols/long) - Return value as long.
    -  [`max-of-type`](#tick.protocols/max-of-type) - Return the max.
    -  [`micros`](#tick.protocols/micros) - Return the given quantity in microseconds.
    -  [`microsecond`](#tick.protocols/microsecond) - Return the millisecond field of the given time.
    -  [`millis`](#tick.protocols/millis) - Return the given quantity in milliseconds.
    -  [`millisecond`](#tick.protocols/millisecond) - Return the millisecond field of the given time.
    -  [`min-of-type`](#tick.protocols/min-of-type) - Return the min.
    -  [`minute`](#tick.protocols/minute) - Return the minute field of the given time.
    -  [`minutes`](#tick.protocols/minutes) - Return the given quantity in minutes.
    -  [`month`](#tick.protocols/month) - Make a java.time.Month instance.
    -  [`months`](#tick.protocols/months) - Return the given quantity in months.
    -  [`nanos`](#tick.protocols/nanos) - Return the given quantity in nanoseconds.
    -  [`nanosecond`](#tick.protocols/nanosecond) - Return the millisecond field of the given time.
    -  [`offset-by`](#tick.protocols/offset-by) - Set a date-time to be offset by an amount.
    -  [`offset-date-time`](#tick.protocols/offset-date-time) - Make a java.time.OffsetDateTime instance.
    -  [`on`](#tick.protocols/on) - Set time be ON a date.
    -  [`parse`](#tick.protocols/parse) - Parse is not in the main api because it is slow and may give surprising behaviour.
    -  [`range`](#tick.protocols/range) - Returns a lazy seq of times from start (inclusive) to end (exclusive, nil means forever), by step, where start defaults to 0, step to 1, and end to infinity.
    -  [`second`](#tick.protocols/second) - Return the second field of the given time.
    -  [`seconds`](#tick.protocols/seconds) - Return the given quantity in seconds.
    -  [`time`](#tick.protocols/time) - Make a java.time.LocalTime instance.
    -  [`truncate`](#tick.protocols/truncate)
    -  [`year`](#tick.protocols/year) - Make a java.time.Year instance.
    -  [`year-month`](#tick.protocols/year-month) - Make a java.time.YearMonth instance.
    -  [`years`](#tick.protocols/years) - Return the given quantity in years.
    -  [`zone`](#tick.protocols/zone) - Make a java.time.ZoneId instance.
    -  [`zone-offset`](#tick.protocols/zone-offset) - Make a java.time.ZoneOffset instance.
    -  [`zoned-date-time`](#tick.protocols/zoned-date-time) - Make a java.time.ZonedDateTime instance.

-----
# <a name="tick.alpha.calendar">tick.alpha.calendar</a>






## <a name="tick.alpha.calendar/bank-holidays-in-england-and-wales">`bank-holidays-in-england-and-wales`</a>
``` clojure
(bank-holidays-in-england-and-wales)
(bank-holidays-in-england-and-wales year)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/calendar.clj#L23-L35">Source</a></sub></p>

## <a name="tick.alpha.calendar/select-by-year">`select-by-year`</a>
``` clojure
(select-by-year year holidays)
```
Function.

Given the sequence of holidays (which must be intervals, such as iCalendar VEvent objects), select only those of a given year.
<p><sub><a href="/blob/main/src/tick/alpha/calendar.clj#L15-L20">Source</a></sub></p>

## <a name="tick.alpha.calendar/weekend?">`weekend?`</a>
``` clojure
(weekend? dt)
```
Function.

Is the ZonedDateTime during the weekend?
<p><sub><a href="/blob/main/src/tick/alpha/calendar.clj#L38-L41">Source</a></sub></p>

-----
# <a name="tick.alpha.ical">tick.alpha.ical</a>






## <a name="tick.alpha.ical/alpha-digit">`ALPHA-DIGIT`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L210-L213">Source</a></sub></p>

## <a name="tick.alpha.ical/control">`CONTROL`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L201-L204">Source</a></sub></p>

## <a name="tick.alpha.ical/crlf">`CRLF`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L19-L19">Source</a></sub></p>

## <a name="tick.alpha.ical/date-time-form-1-pattern">`DATE-TIME-FORM-1-PATTERN`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L48-L48">Source</a></sub></p>

## <a name="tick.alpha.ical/date-time-form-2-pattern">`DATE-TIME-FORM-2-PATTERN`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L51-L51">Source</a></sub></p>

## <a name="tick.alpha.ical/date-time-form-3-pattern">`DATE-TIME-FORM-3-PATTERN`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L53-L53">Source</a></sub></p>

## <a name="tick.alpha.ical/icalendarobject">`ICalendarObject`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L72-L78">Source</a></sub></p>

## <a name="tick.alpha.ical/icalendarvalue">`ICalendarValue`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L45-L46">Source</a></sub></p>

## <a name="tick.alpha.ical/iprintable">`IPrintable`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L80-L81">Source</a></sub></p>

## <a name="tick.alpha.ical/qsafe-char">`QSAFE-CHAR`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L183-L186">Source</a></sub></p>

## <a name="tick.alpha.ical/safe-char">`SAFE-CHAR`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L188-L193">Source</a></sub></p>

## <a name="tick.alpha.ical/value-char">`VALUE-CHAR`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L195-L197">Source</a></sub></p>

## <a name="tick.alpha.ical/add-contentline-to-model">`add-contentline-to-model`</a>




A reducing function that gives a parsed content-line to an
  accumulator that builds a model.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L304-L307">Source</a></sub></p>

## <a name="tick.alpha.ical/add-property">`add-property`</a>
``` clojure
(add-property acc contentline)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L345-L350">Source</a></sub></p>

## <a name="tick.alpha.ical/char-range">`char-range`</a>
``` clojure
(char-range from to)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L180-L181">Source</a></sub></p>

## <a name="tick.alpha.ical/coerce-to-value">`coerce-to-value`</a>



<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L341-L341">Source</a></sub></p>

## <a name="tick.alpha.ical/contentline">`contentline`</a>
``` clojure
(contentline s)
```
Function.

Fold the given string value returning a sequence of strings up to
  75 octets in length, as per RFC 5545 folding rules.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L21-L37">Source</a></sub></p>

## <a name="tick.alpha.ical/error">`error`</a>
``` clojure
(error acc contentline message)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L309-L313">Source</a></sub></p>

## <a name="tick.alpha.ical/events">`events`</a>
``` clojure
(events vcalendar)
```
Function.

Given a vcalendar object, return only the events
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L365-L368">Source</a></sub></p>

## <a name="tick.alpha.ical/extract-name-as-string">`extract-name-as-string`</a>
``` clojure
(extract-name-as-string [k v])
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L274-L278">Source</a></sub></p>

## <a name="tick.alpha.ical/extract-param-value-as-string">`extract-param-value-as-string`</a>
``` clojure
(extract-param-value-as-string [k v])
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L280-L283">Source</a></sub></p>

## <a name="tick.alpha.ical/line->contentline">`line->contentline`</a>
``` clojure
(line->contentline s)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L285-L299">Source</a></sub></p>

## <a name="tick.alpha.ical/parse-ical">`parse-ical`</a>
``` clojure
(parse-ical r)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L356-L363">Source</a></sub></p>

## <a name="tick.alpha.ical/print-cl">`print-cl`</a>
``` clojure
(print-cl & args)
```
Function.

Folding print, where long lines are folded as per RFC 5545 Section 4.1
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L39-L43">Source</a></sub></p>

## <a name="tick.alpha.ical/print-object">`print-object`</a>
``` clojure
(print-object _)
```
Function.

Print as an iCalendar object
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L81-L81">Source</a></sub></p>

## <a name="tick.alpha.ical/print-property">`print-property`</a>
``` clojure
(print-property prop-name prop-value)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L89-L96">Source</a></sub></p>

## <a name="tick.alpha.ical/property-value">`property-value`</a>
``` clojure
(property-value obj prop-name)
```
Function.

Return the first property value of an ICalendarObject.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L77-L78">Source</a></sub></p>

## <a name="tick.alpha.ical/property-values">`property-values`</a>
``` clojure
(property-values obj prop-name)
```
Function.

Return the properties of an ICalendarObject with the given
    name. Returns a sequence of values, since iCalendar properties may
    have multiple values.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L73-L76">Source</a></sub></p>

## <a name="tick.alpha.ical/serialize-value">`serialize-value`</a>
``` clojure
(serialize-value _)
```
Function.


<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L46-L46">Source</a></sub></p>

## <a name="tick.alpha.ical/unfolding-line-seq">`unfolding-line-seq`</a>
``` clojure
(unfolding-line-seq rdr)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L271-L272">Source</a></sub></p>

## <a name="tick.alpha.ical/unfolding-line-seq*">`unfolding-line-seq*`</a>
``` clojure
(unfolding-line-seq* rdr hold)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L262-L269">Source</a></sub></p>

## <a name="tick.alpha.ical/wrap-with">`wrap-with`</a>
``` clojure
(wrap-with c & body)
```
Macro.
<p><sub><a href="/blob/main/src/tick/alpha/ical.clj#L83-L87">Source</a></sub></p>

-----
# <a name="tick.alpha.interval">tick.alpha.interval</a>






## <a name="tick.alpha.interval/->generalrelation">`->GeneralRelation`</a>
``` clojure
(->GeneralRelation relations)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L174-L177">Source</a></sub></p>

## <a name="tick.alpha.interval/generalrelation">`GeneralRelation`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L174-L177">Source</a></sub></p>

## <a name="tick.alpha.interval/idivisibleinterval">`IDivisibleInterval`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L739-L740">Source</a></sub></p>

## <a name="tick.alpha.interval/igroupable">`IGroupable`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L868-L869">Source</a></sub></p>

## <a name="tick.alpha.interval/iintervalops">`IIntervalOps`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L235-L238">Source</a></sub></p>

## <a name="tick.alpha.interval/am">`am`</a>
``` clojure
(am date)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L96-L97">Source</a></sub></p>

## <a name="tick.alpha.interval/basic-relation">`basic-relation`</a>




A function to determine the (basic) relation between two intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L187-L189">Source</a></sub></p>

## <a name="tick.alpha.interval/basic-relations">`basic-relations`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L167-L170">Source</a></sub></p>

## <a name="tick.alpha.interval/bounds">`bounds`</a>
``` clojure
(bounds & args)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L91-L94">Source</a></sub></p>

## <a name="tick.alpha.interval/complement">`complement`</a>
``` clojure
(complement coll)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L628-L640">Source</a></sub></p>

## <a name="tick.alpha.interval/complement-r">`complement-r`</a>
``` clojure
(complement-r r)
```
Function.

Return the complement of the general relation. The complement ~r of
  a relation r is the relation consisting of all basic relations not
  in r.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L196-L201">Source</a></sub></p>

## <a name="tick.alpha.interval/compose-r">`compose-r`</a>
``` clojure
(compose-r _r _s)
```
Function.

Return the composition of r and s
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L208-L211">Source</a></sub></p>

## <a name="tick.alpha.interval/concur">`concur`</a>
``` clojure
(concur x y)
(concur x y & args)
```
Function.

Return the interval representing the interval, if there is one,
  representing the interval of time the given intervals are
  concurrent.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L325-L339">Source</a></sub></p>

## <a name="tick.alpha.interval/concur?">`concur?`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L230-L230">Source</a></sub></p>

## <a name="tick.alpha.interval/concurrencies">`concurrencies`</a>
``` clojure
(concurrencies & intervals)
```
Function.

Return a sequence of occurances where intervals coincide (having
  non-nil concur intervals).
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L341-L353">Source</a></sub></p>

## <a name="tick.alpha.interval/conj">`conj`</a>
``` clojure
(conj coll interval)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L470-L471">Source</a></sub></p>

## <a name="tick.alpha.interval/contains?">`contains?`</a>
``` clojure
(contains? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L149-L149">Source</a></sub></p>

## <a name="tick.alpha.interval/conv">`conv`</a>
``` clojure
(conv f)
```
Function.

The converse of a basic relation.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L137-L141">Source</a></sub></p>

## <a name="tick.alpha.interval/converse-r">`converse-r`</a>
``` clojure
(converse-r r)
```
Function.

Return the converse of the given general relation. The converse !r
  of a relation r is the relation consisting of the converses of all
  basic relations in r.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L213-L218">Source</a></sub></p>

## <a name="tick.alpha.interval/difference">`difference`</a>
``` clojure
(difference s1)
(difference s1 s2)
(difference s1 s2 & sets)
```
Function.

Return an interval set that is the first set without elements of
  the remaining sets.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L564-L626">Source</a></sub></p>

## <a name="tick.alpha.interval/disjoin">`disjoin`</a>
``` clojure
(disjoin s1)
(disjoin s1 s2)
(disjoin s1 s2 & sets)
```
Function.

Split s1 across the grating defined by s2
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L642-L669">Source</a></sub></p>

## <a name="tick.alpha.interval/disjoint?">`disjoint?`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L229-L229">Source</a></sub></p>

## <a name="tick.alpha.interval/divide">`divide`</a>
``` clojure
(divide t divisor)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L895-L896">Source</a></sub></p>

## <a name="tick.alpha.interval/divide-by">`divide-by`</a>
``` clojure
(divide-by divisor t)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L891-L892">Source</a></sub></p>

## <a name="tick.alpha.interval/divide-by-divisor">`divide-by-divisor`</a>
``` clojure
(divide-by-divisor ival divisor)
```
Function.

Divides the interval specified by `ival` into `divisor` spaced
  intervals. The `divisor` must be a positive integer. The calculated
  subintervals are exact down to the nearest nanosecond.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L709-L737">Source</a></sub></p>

## <a name="tick.alpha.interval/divide-by-duration">`divide-by-duration`</a>
``` clojure
(divide-by-duration ival dur)
```
Function.

Divide an interval by a duration, returning a sequence of
  intervals. If the interval cannot be wholly sub-divided by the
  duration divisor, the last interval will represent the 'remainder'
  of the division and not be as long as the other preceeding
  intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L686-L698">Source</a></sub></p>

## <a name="tick.alpha.interval/divide-by-period">`divide-by-period`</a>
``` clojure
(divide-by-period ival period)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L700-L707">Source</a></sub></p>

## <a name="tick.alpha.interval/divide-interval">`divide-interval`</a>
``` clojure
(divide-interval divisor ival)
```
Function.

Divide an interval by a given divisor
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L740-L740">Source</a></sub></p>

## <a name="tick.alpha.interval/during?">`during?`</a>
``` clojure
(during? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L121-L124">Source</a></sub></p>

## <a name="tick.alpha.interval/equals?">`equals?`</a>
``` clojure
(equals? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L107-L110">Source</a></sub></p>

## <a name="tick.alpha.interval/extend">`extend`</a>
``` clojure
(extend ival dur)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L46-L49">Source</a></sub></p>

## <a name="tick.alpha.interval/finished-by?">`finished-by?`</a>
``` clojure
(finished-by? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L146-L146">Source</a></sub></p>

## <a name="tick.alpha.interval/finishes?">`finishes?`</a>
``` clojure
(finishes? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L131-L134">Source</a></sub></p>

## <a name="tick.alpha.interval/flatten">`flatten`</a>
``` clojure
(flatten s)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L267-L272">Source</a></sub></p>

## <a name="tick.alpha.interval/group-by">`group-by`</a>
``` clojure
(group-by grouping ivals)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L869-L869">Source</a></sub></p>

## <a name="tick.alpha.interval/group-by-intervals">`group-by-intervals`</a>
``` clojure
(group-by-intervals intervals-to-group-by ivals)
```
Function.

Divide intervals in s1 by (disjoint ordered) intervals in s2,
  splitting if necessary, grouping by s2. Complexity is O(n) rather
  than O(n^2)
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L772-L866">Source</a></sub></p>

## <a name="tick.alpha.interval/intersection">`intersection`</a>
``` clojure
(intersection s1)
(intersection s1 s2)
(intersection s1 s2 & sets)
```
Function.

Return a time-ordered sequence of disjoint intervals where two or
  more intervals of the given sequences are concurrent. Arguments must
  be time-ordered sequences of disjoint intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L473-L559">Source</a></sub></p>

## <a name="tick.alpha.interval/intersection-r">`intersection-r`</a>
``` clojure
(intersection-r r _s)
```
Function.

Return the intersection of the r with s
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L220-L225">Source</a></sub></p>

## <a name="tick.alpha.interval/intersects?">`intersects?`</a>
``` clojure
(intersects? ivals interval)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L561-L562">Source</a></sub></p>

## <a name="tick.alpha.interval/interval">`interval`</a>
``` clojure
(interval t)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L358-L359">Source</a></sub></p>

## <a name="tick.alpha.interval/map->generalrelation">`map->GeneralRelation`</a>
``` clojure
(map->GeneralRelation m)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L174-L177">Source</a></sub></p>

## <a name="tick.alpha.interval/meets?">`meets?`</a>
``` clojure
(meets? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L112-L113">Source</a></sub></p>

## <a name="tick.alpha.interval/met-by?">`met-by?`</a>
``` clojure
(met-by? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L144-L144">Source</a></sub></p>

## <a name="tick.alpha.interval/new-interval">`new-interval`</a>
``` clojure
(new-interval v1 v2)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L28-L39">Source</a></sub></p>

## <a name="tick.alpha.interval/new-interval-group">`new-interval-group`</a>
``` clojure
(new-interval-group x)
```
Function.

Return an interval group. Interval groups are maps with
  a :tick/intervals entry that contain a time-ordered sequence of
  disjoint intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L427-L434">Source</a></sub></p>

## <a name="tick.alpha.interval/new-relation">`new-relation`</a>
``` clojure
(new-relation & basic-relations)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L184-L185">Source</a></sub></p>

## <a name="tick.alpha.interval/normalize">`normalize`</a>
``` clojure
(normalize intervals)
```
Function.

Within a time-ordered sequence of disjoint intervals, return a
  sequence of interval groups, splicing together meeting intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L436-L448">Source</a></sub></p>

## <a name="tick.alpha.interval/not-yet-implemented">`not-yet-implemented`</a>
``` clojure
(not-yet-implemented)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L203-L206">Source</a></sub></p>

## <a name="tick.alpha.interval/ordered-disjoint-intervals?">`ordered-disjoint-intervals?`</a>
``` clojure
(ordered-disjoint-intervals? s)
```
Function.

Are all the intervals in the given set time-ordered and
  disjoint? This is a useful property of a collection of
  intervals. The given collection must contain proper intervals (that
  is, intervals that have finite greater-than-zero durations).
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L373-L384">Source</a></sub></p>

## <a name="tick.alpha.interval/overlapped-by?">`overlapped-by?`</a>
``` clojure
(overlapped-by? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L145-L145">Source</a></sub></p>

## <a name="tick.alpha.interval/overlaps?">`overlaps?`</a>
``` clojure
(overlaps? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L115-L119">Source</a></sub></p>

## <a name="tick.alpha.interval/pm">`pm`</a>
``` clojure
(pm date)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L99-L100">Source</a></sub></p>

## <a name="tick.alpha.interval/preceded-by?">`preceded-by?`</a>
``` clojure
(preceded-by? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L143-L143">Source</a></sub></p>

## <a name="tick.alpha.interval/precedes-or-meets?">`precedes-or-meets?`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L231-L231">Source</a></sub></p>

## <a name="tick.alpha.interval/precedes?">`precedes?`</a>
``` clojure
(precedes? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L104-L105">Source</a></sub></p>

## <a name="tick.alpha.interval/relation">`relation`</a>
``` clojure
(relation x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L191-L192">Source</a></sub></p>

## <a name="tick.alpha.interval/relation->kw">`relation->kw`</a>



<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L152-L165">Source</a></sub></p>

## <a name="tick.alpha.interval/scale">`scale`</a>
``` clojure
(scale ival factor)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L51-L54">Source</a></sub></p>

## <a name="tick.alpha.interval/slice">`slice`</a>
``` clojure
(slice this beginning end)
```
Function.

Fit the interval between beginning and end, slicing off one or both ends as necessary
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L236-L236">Source</a></sub></p>

## <a name="tick.alpha.interval/slice-interval">`slice-interval`</a>
``` clojure
(slice-interval ival beginning end)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L246-L252">Source</a></sub></p>

## <a name="tick.alpha.interval/splice">`splice`</a>
``` clojure
(splice this ival)
```
Function.

Splice another interval on to this one
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L237-L237">Source</a></sub></p>

## <a name="tick.alpha.interval/split">`split`</a>
``` clojure
(split this t)
```
Function.

Split ival into 2 intervals at t, returned as a 2-element vector
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L238-L238">Source</a></sub></p>

## <a name="tick.alpha.interval/split-interval">`split-interval`</a>
``` clojure
(split-interval ival t)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L254-L256">Source</a></sub></p>

## <a name="tick.alpha.interval/split-with-assert">`split-with-assert`</a>
``` clojure
(split-with-assert ival t)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L240-L244">Source</a></sub></p>

## <a name="tick.alpha.interval/started-by?">`started-by?`</a>
``` clojure
(started-by? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L150-L150">Source</a></sub></p>

## <a name="tick.alpha.interval/starts?">`starts?`</a>
``` clojure
(starts? x y)
```
Function.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L126-L129">Source</a></sub></p>

## <a name="tick.alpha.interval/union">`union`</a>
``` clojure
(union & colls)
```
Function.

Merge multiple time-ordered sequences of disjoint intervals into a
  single sequence of time-ordered disjoint intervals.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L450-L468">Source</a></sub></p>

## <a name="tick.alpha.interval/unite">`unite`</a>
``` clojure
(unite intervals)
```
Function.

Unite concurrent intervals. Intervals must be ordered by beginning
  but not necessarily disjoint (the purpose of this function is to
  splice together intervals that are concurrent resulting in a
  time-ordered sequence of disjoint intervals that is returned.
<p><sub><a href="/blob/main/src/tick/alpha/interval.cljc#L404-L425">Source</a></sub></p>

-----
# <a name="tick.core">tick.core</a>






## <a name="tick.core/*clock*">`*clock*`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L101-L101">Source</a></sub></p>

## <a name="tick.core/*time-literals-printing*">`*time-literals-printing*`</a>




If true, include the time-literals printer, which will affect the way java.time and js-joda objects are printed
<p><sub><a href="/blob/main/src/tick/core.cljc#L53-L57">Source</a></sub></p>

## <a name="tick.core/+">`+`</a>
``` clojure
(+)
(+ arg)
(+ arg & args)
```
Function.

Sum amounts of time
<p><sub><a href="/blob/main/src/tick/core.cljc#L821-L826">Source</a></sub></p>

## <a name="tick.core/-">`-`</a>
``` clojure
(-)
(- arg)
(- arg & args)
```
Function.

Subtract amounts of time.
<p><sub><a href="/blob/main/src/tick/core.cljc#L828-L833">Source</a></sub></p>

## <a name="tick.core/->atomicclock">`->AtomicClock`</a>
``` clojure
(->AtomicClock *clock)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L760-L764">Source</a></sub></p>

## <a name="tick.core/->fieldslookup">`->FieldsLookup`</a>
``` clojure
(->FieldsLookup t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L475-L489">Source</a></sub></p>

## <a name="tick.core/<">`<`</a>
``` clojure
(< _x)
(< x y)
(< x y & more)
```
Function.

Same as clojure.core/<, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1392-L1400">Source</a></sub></p>

## <a name="tick.core/<<">`<<`</a>
``` clojure
(<< t n-or-d)
```
Function.

shift Temporal backward
<p><sub><a href="/blob/main/src/tick/core.cljc#L879-L882">Source</a></sub></p>

## <a name="tick.core/<=">`<=`</a>
``` clojure
(<= _x)
(<= x y)
(<= x y & more)
```
Function.

Same as clojure.core/<=, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1402-L1410">Source</a></sub></p>

## <a name="tick.core/=">`=`</a>
``` clojure
(= _x)
(= x y)
(= x y & more)
```
Function.

Same as clojure.core/=, but works on dates, rather than numbers.
  can compare different types, e.g. Instant vs ZonedDateTime
  
<p><sub><a href="/blob/main/src/tick/core.cljc#L1380-L1390">Source</a></sub></p>

## <a name="tick.core/>">`>`</a>
``` clojure
(> _x)
(> x y)
(> x y & more)
```
Function.

Same as clojure.core/>, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1412-L1420">Source</a></sub></p>

## <a name="tick.core/>=">`>=`</a>
``` clojure
(>= _x)
(>= x y)
(>= x y & more)
```
Function.

Same as clojure.core/>=, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1422-L1430">Source</a></sub></p>

## <a name="tick.core/>>">`>>`</a>
``` clojure
(>> t n-or-d)
```
Function.

shift Temporal forward
<p><sub><a href="/blob/main/src/tick/core.cljc#L874-L877">Source</a></sub></p>

## <a name="tick.core/april">`APRIL`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1151-L1151">Source</a></sub></p>

## <a name="tick.core/august">`AUGUST`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1155-L1155">Source</a></sub></p>

## <a name="tick.core/atomicclock">`AtomicClock`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L760-L764">Source</a></sub></p>

## <a name="tick.core/december">`DECEMBER`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1159-L1159">Source</a></sub></p>

## <a name="tick.core/february">`FEBRUARY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1149-L1149">Source</a></sub></p>

## <a name="tick.core/friday">`FRIDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1144-L1144">Source</a></sub></p>

## <a name="tick.core/fieldslookup">`FieldsLookup`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L475-L489">Source</a></sub></p>

## <a name="tick.core/january">`JANUARY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1148-L1148">Source</a></sub></p>

## <a name="tick.core/july">`JULY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1154-L1154">Source</a></sub></p>

## <a name="tick.core/june">`JUNE`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1153-L1153">Source</a></sub></p>

## <a name="tick.core/march">`MARCH`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1150-L1150">Source</a></sub></p>

## <a name="tick.core/may">`MAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1152-L1152">Source</a></sub></p>

## <a name="tick.core/monday">`MONDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1140-L1140">Source</a></sub></p>

## <a name="tick.core/november">`NOVEMBER`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1158-L1158">Source</a></sub></p>

## <a name="tick.core/october">`OCTOBER`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1157-L1157">Source</a></sub></p>

## <a name="tick.core/saturday">`SATURDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1145-L1145">Source</a></sub></p>

## <a name="tick.core/september">`SEPTEMBER`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1156-L1156">Source</a></sub></p>

## <a name="tick.core/sunday">`SUNDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1146-L1146">Source</a></sub></p>

## <a name="tick.core/thursday">`THURSDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1143-L1143">Source</a></sub></p>

## <a name="tick.core/tuesday">`TUESDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1141-L1141">Source</a></sub></p>

## <a name="tick.core/utc">`UTC`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1161-L1161">Source</a></sub></p>

## <a name="tick.core/wednesday">`WEDNESDAY`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1142-L1142">Source</a></sub></p>

## <a name="tick.core/ago">`ago`</a>
``` clojure
(ago dur)
```
Function.

current instant shifted back by duration 'dur'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1113-L1114">Source</a></sub></p>

## <a name="tick.core/at">`at`</a>
``` clojure
(at d t)
```
Function.

Set date to be AT a time
<p><sub><a href="/blob/main/src/tick/core.cljc#L1175-L1175">Source</a></sub></p>

## <a name="tick.core/atom">`atom`</a>
``` clojure
(atom clk)
(atom)
```
Function.

construct atomic clock
<p><sub><a href="/blob/main/src/tick/core.cljc#L773-L776">Source</a></sub></p>

## <a name="tick.core/backward-compatible-time-span-extensions">`backward-compatible-time-span-extensions`</a>
``` clojure
(backward-compatible-time-span-extensions)
```
Function.

pre v0.7, ITimeSpan was extended as per this body. run this function to create those extensions.
  
  ITimeSpan is implemented by default on types with a natural beginning and end
<p><sub><a href="/blob/main/src/tick/core.cljc#L1011-L1043">Source</a></sub></p>

## <a name="tick.core/beginning">`beginning`</a>
``` clojure
(beginning v)
```
Function.

the beginning of the range of ITimeSpan v or v
<p><sub><a href="/blob/main/src/tick/core.cljc#L969-L969">Source</a></sub></p>

## <a name="tick.core/between">`between`</a>
``` clojure
(between v1 v2)
(between v1 v2 unit)
```
Function.

for the 2-arity version, find the temporal-amount between v1 and v2, 
or for the 3-arity version the amount of 'unit' between v1 and v2
<p><sub><a href="/blob/main/src/tick/core.cljc#L961-L967">Source</a></sub></p>

## <a name="tick.core/clock">`clock`</a>
``` clojure
(clock)
(clock i)
```
Function.

return i as a clock
<p><sub><a href="/blob/main/src/tick/core.cljc#L1308-L1311">Source</a></sub></p>

## <a name="tick.core/clock?">`clock?`</a>
``` clojure
(clock? v)
```
Function.

true if v is a clock?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1123-L1123">Source</a></sub></p>

## <a name="tick.core/coincident?">`coincident?`</a>
``` clojure
(coincident? containing-interval contained-interval)
(coincident? start end event)
```
Function.

for the 2-arity ver, Does containing-interval wholly contain the given contained-interval?
  
  for the 3-arity, does the event lie within the span of time described by start and end
<p><sub><a href="/blob/main/src/tick/core.cljc#L1435-L1446">Source</a></sub></p>

## <a name="tick.core/compare-and-set!">`compare-and-set!`</a>
``` clojure
(compare-and-set! at oldval newval)
```
Function.

cas on atomic clock 'at' 
<p><sub><a href="/blob/main/src/tick/core.cljc#L788-L794">Source</a></sub></p>

## <a name="tick.core/current-clock">`current-clock`</a>
``` clojure
(current-clock)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L715-L716">Source</a></sub></p>

## <a name="tick.core/current-zone">`current-zone`</a>
``` clojure
(current-zone)
```
Function.

Return the current zone, which can be overridden by the *clock* dynamic var
<p><sub><a href="/blob/main/src/tick/core.cljc#L187-L192">Source</a></sub></p>

## <a name="tick.core/date">`date`</a>
``` clojure
(date)
(date v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1179-L1181">Source</a></sub></p>

## <a name="tick.core/date-time">`date-time`</a>
``` clojure
(date-time)
(date-time v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1191-L1193">Source</a></sub></p>

## <a name="tick.core/date-time?">`date-time?`</a>
``` clojure
(date-time? v)
```
Function.

true if v is a date-time?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1128-L1128">Source</a></sub></p>

## <a name="tick.core/date?">`date?`</a>
``` clojure
(date? v)
```
Function.

true if v is a date?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1127-L1127">Source</a></sub></p>

## <a name="tick.core/day-of-month">`day-of-month`</a>
``` clojure
(day-of-month)
(day-of-month v)
```
Function.

extract day-of-month from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1288-L1291">Source</a></sub></p>

## <a name="tick.core/day-of-week">`day-of-week`</a>
``` clojure
(day-of-week)
(day-of-week v)
```
Function.

extract day-of-week from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1283-L1286">Source</a></sub></p>

## <a name="tick.core/day-of-week-in-month">`day-of-week-in-month`</a>
``` clojure
(day-of-week-in-month ordinal day-of-week)
(day-of-week-in-month t ordinal day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L507-L509">Source</a></sub></p>

## <a name="tick.core/day-of-week?">`day-of-week?`</a>
``` clojure
(day-of-week? v)
```
Function.

true if v is a day-of-week?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1124-L1124">Source</a></sub></p>

## <a name="tick.core/days">`days`</a>
``` clojure
(days v)
```
Function.

extract days from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1536-L1536">Source</a></sub></p>

## <a name="tick.core/dec">`dec`</a>
``` clojure
(dec t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L912-L912">Source</a></sub></p>

## <a name="tick.core/divide">`divide`</a>
``` clojure
(divide t divisor)
```
Function.

divide TemporalAmount t by divisor, which is a unit e.g. :hours or a TemporalAmount
<p><sub><a href="/blob/main/src/tick/core.cljc#L1540-L1541">Source</a></sub></p>

## <a name="tick.core/duration">`duration`</a>
``` clojure
(duration x)
```
Function.

return Duration or Period (whichever appropriate based on type) contained within the range of ITimeSpan x
<p><sub><a href="/blob/main/src/tick/core.cljc#L972-L973">Source</a></sub></p>

## <a name="tick.core/duration?">`duration?`</a>
``` clojure
(duration? v)
```
Function.

true if v is a duration?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1125-L1125">Source</a></sub></p>

## <a name="tick.core/end">`end`</a>
``` clojure
(end v)
```
Function.

the end of the range of ITimeSpan v or v
<p><sub><a href="/blob/main/src/tick/core.cljc#L970-L970">Source</a></sub></p>

## <a name="tick.core/epoch">`epoch`</a>
``` clojure
(epoch)
```
Function.

Constant for the 1970-01-01T00:00:00Z epoch instant
<p><sub><a href="/blob/main/src/tick/core.cljc#L109-L110">Source</a></sub></p>

## <a name="tick.core/field-map">`field-map`</a>




keyword to chrono-field
<p><sub><a href="/blob/main/src/tick/core.cljc#L415-L447">Source</a></sub></p>

## <a name="tick.core/fields">`fields`</a>
``` clojure
(fields t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L493-L493">Source</a></sub></p>

## <a name="tick.core/first-day-of-month">`first-day-of-month`</a>
``` clojure
(first-day-of-month)
(first-day-of-month t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L511-L513">Source</a></sub></p>

## <a name="tick.core/first-day-of-next-month">`first-day-of-next-month`</a>
``` clojure
(first-day-of-next-month)
(first-day-of-next-month t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L515-L517">Source</a></sub></p>

## <a name="tick.core/first-day-of-next-year">`first-day-of-next-year`</a>
``` clojure
(first-day-of-next-year)
(first-day-of-next-year t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L519-L521">Source</a></sub></p>

## <a name="tick.core/first-day-of-year">`first-day-of-year`</a>
``` clojure
(first-day-of-year)
(first-day-of-year t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L523-L525">Source</a></sub></p>

## <a name="tick.core/first-in-month">`first-in-month`</a>
``` clojure
(first-in-month day-of-week)
(first-in-month t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L527-L529">Source</a></sub></p>

## <a name="tick.core/format">`format`</a>
``` clojure
(format o)
(format fmt o)
```
Function.

Formats the given time entity as a string.
  Accepts something that can be converted to a `DateTimeFormatter` as a first
  argument. Given one argument uses the default format.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1370-L1376">Source</a></sub></p>

## <a name="tick.core/formatter">`formatter`</a>
``` clojure
(formatter fmt)
(formatter fmt locale)
```
Function.

Constructs a DateTimeFormatter out of either a

  * format string - "yyyy/MM/dd" "yyy HH:mm" etc.
  or
  * formatter name - :iso-instant :iso-local-date etc

  and a Locale, which is optional.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1341-L1368">Source</a></sub></p>

## <a name="tick.core/greater">`greater`</a>
``` clojure
(greater x y)
```
Function.

the greater of x and y
<p><sub><a href="/blob/main/src/tick/core.cljc#L1432-L1433">Source</a></sub></p>

## <a name="tick.core/hence">`hence`</a>
``` clojure
(hence dur)
```
Function.

current instant shifted forward by duration 'dur'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1116-L1117">Source</a></sub></p>

## <a name="tick.core/hour">`hour`</a>
``` clojure
(hour t)
```
Function.

extract hour from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1274-L1274">Source</a></sub></p>

## <a name="tick.core/hours">`hours`</a>
``` clojure
(hours v)
```
Function.

extract hours from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1535-L1535">Source</a></sub></p>

## <a name="tick.core/in">`in`</a>
``` clojure
(in ldt z)
```
Function.

Set a date-time to be in a time-zone
<p><sub><a href="/blob/main/src/tick/core.cljc#L1176-L1176">Source</a></sub></p>

## <a name="tick.core/inc">`inc`</a>
``` clojure
(inc t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L911-L911">Source</a></sub></p>

## <a name="tick.core/inst">`inst`</a>
``` clojure
(inst)
(inst v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1183-L1185">Source</a></sub></p>

## <a name="tick.core/instant">`instant`</a>
``` clojure
(instant)
(instant v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1187-L1189">Source</a></sub></p>

## <a name="tick.core/instant?">`instant?`</a>
``` clojure
(instant? v)
```
Function.

true if v is a instant?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1126-L1126">Source</a></sub></p>

## <a name="tick.core/int">`int`</a>
``` clojure
(int arg)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1169-L1169">Source</a></sub></p>

## <a name="tick.core/interval?">`interval?`</a>
``` clojure
(interval? v)
```
Function.

true if v is a interval?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1138-L1138">Source</a></sub></p>

## <a name="tick.core/last-day-of-month">`last-day-of-month`</a>
``` clojure
(last-day-of-month)
(last-day-of-month t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L531-L533">Source</a></sub></p>

## <a name="tick.core/last-day-of-year">`last-day-of-year`</a>
``` clojure
(last-day-of-year)
(last-day-of-year t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L535-L537">Source</a></sub></p>

## <a name="tick.core/last-in-month">`last-in-month`</a>
``` clojure
(last-in-month day-of-week)
(last-in-month t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L539-L541">Source</a></sub></p>

## <a name="tick.core/lesser">`lesser`</a>
``` clojure
(lesser x y)
```
Function.

the lesser of x and y
<p><sub><a href="/blob/main/src/tick/core.cljc#L1455-L1456">Source</a></sub></p>

## <a name="tick.core/long">`long`</a>
``` clojure
(long arg)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1170-L1170">Source</a></sub></p>

## <a name="tick.core/map->atomicclock">`map->AtomicClock`</a>
``` clojure
(map->AtomicClock m)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L760-L764">Source</a></sub></p>

## <a name="tick.core/max">`max`</a>
``` clojure
(max arg & args)
```
Function.

Find the latest of the given arguments. Callers should ensure that no
  argument is nil.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1448-L1453">Source</a></sub></p>

## <a name="tick.core/max-key">`max-key`</a>
``` clojure
(max-key _k x)
(max-key k x y)
(max-key k x y & more)
```
Function.

Same as clojure.core/max-key, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1465-L1479">Source</a></sub></p>

## <a name="tick.core/max-of-type">`max-of-type`</a>




return e.g Instant/MAX given and Instant
<p><sub><a href="/blob/main/src/tick/core.cljc#L1164-L1164">Source</a></sub></p>

## <a name="tick.core/micros">`micros`</a>
``` clojure
(micros v)
```
Function.

extract micros from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1531-L1531">Source</a></sub></p>

## <a name="tick.core/microsecond">`microsecond`</a>
``` clojure
(microsecond t)
```
Function.

extract microsecond from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1270-L1270">Source</a></sub></p>

## <a name="tick.core/midnight">`midnight`</a>
``` clojure
(midnight)
(midnight date)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L113-L116">Source</a></sub></p>

## <a name="tick.core/midnight?">`midnight?`</a>
``` clojure
(midnight? t)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1119-L1120">Source</a></sub></p>

## <a name="tick.core/millis">`millis`</a>
``` clojure
(millis v)
```
Function.

extract millis from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1532-L1532">Source</a></sub></p>

## <a name="tick.core/millisecond">`millisecond`</a>
``` clojure
(millisecond t)
```
Function.

extract millisecond from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1271-L1271">Source</a></sub></p>

## <a name="tick.core/min">`min`</a>
``` clojure
(min arg & args)
```
Function.

Find the earliest of the given arguments. Callers should ensure that no
  argument is nil.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1458-L1463">Source</a></sub></p>

## <a name="tick.core/min-key">`min-key`</a>
``` clojure
(min-key _k x)
(min-key k x y)
(min-key k x y & more)
```
Function.

Same as clojure.core/min-key, but works on dates, rather than numbers
<p><sub><a href="/blob/main/src/tick/core.cljc#L1481-L1495">Source</a></sub></p>

## <a name="tick.core/min-of-type">`min-of-type`</a>




return e.g Instant/MIN given and Instant
<p><sub><a href="/blob/main/src/tick/core.cljc#L1163-L1163">Source</a></sub></p>

## <a name="tick.core/minute">`minute`</a>
``` clojure
(minute t)
```
Function.

extract minute from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1273-L1273">Source</a></sub></p>

## <a name="tick.core/minutes">`minutes`</a>
``` clojure
(minutes v)
```
Function.

extract minutes from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1534-L1534">Source</a></sub></p>

## <a name="tick.core/modify-printing-of-time-literals-if-enabled!">`modify-printing-of-time-literals-if-enabled!`</a>
``` clojure
(modify-printing-of-time-literals-if-enabled!)
```
Macro.
<p><sub><a href="/blob/main/src/tick/core.cljc#L60-L64">Source</a></sub></p>

## <a name="tick.core/month">`month`</a>
``` clojure
(month)
(month v)
```
Function.

extract month from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1293-L1296">Source</a></sub></p>

## <a name="tick.core/month?">`month?`</a>
``` clojure
(month? v)
```
Function.

true if v is a month?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1130-L1130">Source</a></sub></p>

## <a name="tick.core/months">`months`</a>
``` clojure
(months v)
```
Function.

extract months from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1537-L1537">Source</a></sub></p>

## <a name="tick.core/nanos">`nanos`</a>
``` clojure
(nanos v)
```
Function.

extract nanos from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1530-L1530">Source</a></sub></p>

## <a name="tick.core/nanosecond">`nanosecond`</a>
``` clojure
(nanosecond t)
```
Function.

extract nanosecond from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1269-L1269">Source</a></sub></p>

## <a name="tick.core/negated">`negated`</a>
``` clojure
(negated d)
```
Function.

Return the duration as a negative duration
<p><sub><a href="/blob/main/src/tick/core.cljc#L816-L819">Source</a></sub></p>

## <a name="tick.core/new-date">`new-date`</a>
``` clojure
(new-date)
(new-date year month day-of-month)
(new-date year day-of-year)
(new-date epoch-day)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L172-L179">Source</a></sub></p>

## <a name="tick.core/new-duration">`new-duration`</a>
``` clojure
(new-duration n u)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L643-L646">Source</a></sub></p>

## <a name="tick.core/new-period">`new-period`</a>
``` clojure
(new-period n u)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L648-L653">Source</a></sub></p>

## <a name="tick.core/new-time">`new-time`</a>
``` clojure
(new-time)
(new-time hour minute)
(new-time hour minute second)
(new-time hour minute second nano)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L166-L170">Source</a></sub></p>

## <a name="tick.core/new-year-month">`new-year-month`</a>
``` clojure
(new-year-month)
(new-year-month year month)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L182-L185">Source</a></sub></p>

## <a name="tick.core/next">`next`</a>
``` clojure
(next day-of-week)
(next t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L543-L545">Source</a></sub></p>

## <a name="tick.core/next-or-same">`next-or-same`</a>
``` clojure
(next-or-same day-of-week)
(next-or-same t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L547-L549">Source</a></sub></p>

## <a name="tick.core/noon">`noon`</a>
``` clojure
(noon)
(noon date)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L118-L121">Source</a></sub></p>

## <a name="tick.core/now">`now`</a>
``` clojure
(now)
```
Function.

same as (t/instant)
<p><sub><a href="/blob/main/src/tick/core.cljc#L103-L104">Source</a></sub></p>

## <a name="tick.core/of-days">`of-days`</a>
``` clojure
(of-days n)
```
Function.

Takes a java.lang.Long n and returns a period of n days.
<p><sub><a href="/blob/main/src/tick/core.cljc#L692-L695">Source</a></sub></p>

## <a name="tick.core/of-hours">`of-hours`</a>
``` clojure
(of-hours n)
```
Function.

Takes a java.lang.Long n and returns a duration of n hours.
<p><sub><a href="/blob/main/src/tick/core.cljc#L683-L686">Source</a></sub></p>

## <a name="tick.core/of-micros">`of-micros`</a>
``` clojure
(of-micros n)
```
Function.

Takes a java.lang.Long n and returns a duration of n micros.
<p><sub><a href="/blob/main/src/tick/core.cljc#L663-L666">Source</a></sub></p>

## <a name="tick.core/of-millis">`of-millis`</a>
``` clojure
(of-millis n)
```
Function.

Takes a java.lang.Long n and returns a duration of n micros.
<p><sub><a href="/blob/main/src/tick/core.cljc#L668-L671">Source</a></sub></p>

## <a name="tick.core/of-minutes">`of-minutes`</a>
``` clojure
(of-minutes n)
```
Function.

Takes a java.lang.Long n and returns a duration of n minutes.
<p><sub><a href="/blob/main/src/tick/core.cljc#L678-L681">Source</a></sub></p>

## <a name="tick.core/of-months">`of-months`</a>
``` clojure
(of-months n)
```
Function.

Takes a java.lang.Long n and returns a period of n months.
<p><sub><a href="/blob/main/src/tick/core.cljc#L697-L700">Source</a></sub></p>

## <a name="tick.core/of-nanos">`of-nanos`</a>
``` clojure
(of-nanos n)
```
Function.

Takes a java.lang.Long n and returns a duration of n nanoseconds.
<p><sub><a href="/blob/main/src/tick/core.cljc#L658-L661">Source</a></sub></p>

## <a name="tick.core/of-seconds">`of-seconds`</a>
``` clojure
(of-seconds n)
```
Function.

Takes a java.lang.Long n and returns a duration of n seconds.
<p><sub><a href="/blob/main/src/tick/core.cljc#L673-L676">Source</a></sub></p>

## <a name="tick.core/of-years">`of-years`</a>
``` clojure
(of-years n)
```
Function.

Takes a java.lang.Long n and returns a period of n years.
<p><sub><a href="/blob/main/src/tick/core.cljc#L702-L705">Source</a></sub></p>

## <a name="tick.core/offset-by">`offset-by`</a>
``` clojure
(offset-by ldt offset)
```
Function.

Set a date-time to be offset by an amount
<p><sub><a href="/blob/main/src/tick/core.cljc#L1177-L1177">Source</a></sub></p>

## <a name="tick.core/offset-date-time">`offset-date-time`</a>
``` clojure
(offset-date-time)
(offset-date-time v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1195-L1197">Source</a></sub></p>

## <a name="tick.core/offset-date-time?">`offset-date-time?`</a>
``` clojure
(offset-date-time? v)
```
Function.

true if v is a offset-date-time?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1131-L1131">Source</a></sub></p>

## <a name="tick.core/on">`on`</a>
``` clojure
(on t d)
```
Function.

Set time be ON a date
<p><sub><a href="/blob/main/src/tick/core.cljc#L1174-L1174">Source</a></sub></p>

## <a name="tick.core/parse-date">`parse-date`</a>
``` clojure
(parse-date date-str formatter)
```
Function.

to parse an iso-formatted date, use (t/date "2020..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1543-L1546">Source</a></sub></p>

## <a name="tick.core/parse-date-time">`parse-date-time`</a>
``` clojure
(parse-date-time date-str formatter)
```
Function.

to parse an iso-formatted date-time, use (t/date-time "2020..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1547-L1550">Source</a></sub></p>

## <a name="tick.core/parse-day">`parse-day`</a>
``` clojure
(parse-day input)
```
Function.

en locale specific and borderline deprecated.
  consider writing your own regex or use a formatter. For example:

  (-> (t/formatter "EEE")
      (cljc.java-time.format.date-time-formatter/parse "Tue")
      (cljc.java-time.day-of-week/from))
  
<p><sub><a href="/blob/main/src/tick/core.cljc#L123-L140">Source</a></sub></p>

## <a name="tick.core/parse-month">`parse-month`</a>
``` clojure
(parse-month input)
```
Function.

en locale specific and borderline deprecated. Consider writing your
   own regex or use a formatter. For example:

   (-> (t/formatter "MMM")
       (cljc.java-time.format.date-time-formatter/parse "Jan")
       (cljc.java-time.month/from))
   
<p><sub><a href="/blob/main/src/tick/core.cljc#L142-L164">Source</a></sub></p>

## <a name="tick.core/parse-offset-date-time">`parse-offset-date-time`</a>
``` clojure
(parse-offset-date-time date-str formatter)
```
Function.

to parse an iso-formatted offset-date-time, use (t/offset-date-time "2020..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1555-L1558">Source</a></sub></p>

## <a name="tick.core/parse-time">`parse-time`</a>
``` clojure
(parse-time date-str formatter)
```
Function.

to parse an iso-formatted time, use (t/time "20:20..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1551-L1554">Source</a></sub></p>

## <a name="tick.core/parse-year">`parse-year`</a>
``` clojure
(parse-year date-str formatter)
```
Function.

to parse an iso-formatted year, use (t/year "2020") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1559-L1562">Source</a></sub></p>

## <a name="tick.core/parse-year-month">`parse-year-month`</a>
``` clojure
(parse-year-month date-str formatter)
```
Function.

to parse an iso-formatted year-month, use (t/year-month "2020..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1563-L1566">Source</a></sub></p>

## <a name="tick.core/parse-zoned-date-time">`parse-zoned-date-time`</a>
``` clojure
(parse-zoned-date-time date-str formatter)
```
Function.

to parse an iso-formatted zoned-date-time, use (t/zoned-date-time "2020..") instead
<p><sub><a href="/blob/main/src/tick/core.cljc#L1567-L1570">Source</a></sub></p>

## <a name="tick.core/period?">`period?`</a>
``` clojure
(period? v)
```
Function.

true if v is a period?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1132-L1132">Source</a></sub></p>

## <a name="tick.core/predefined-formatters">`predefined-formatters`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L1321-L1339">Source</a></sub></p>

## <a name="tick.core/previous">`previous`</a>
``` clojure
(previous day-of-week)
(previous t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L551-L553">Source</a></sub></p>

## <a name="tick.core/previous-or-same">`previous-or-same`</a>
``` clojure
(previous-or-same day-of-week)
(previous-or-same t day-of-week)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L555-L557">Source</a></sub></p>

## <a name="tick.core/range">`range`</a>




Returns a lazy seq of times from start (inclusive) to end (exclusive, nil means forever), by step, where start defaults to 0, step to 1, and end to infinity.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1166-L1167">Source</a></sub></p>

## <a name="tick.core/reset!">`reset!`</a>
``` clojure
(reset! at newval)
```
Function.

reset! on atomic clock 'at' 
<p><sub><a href="/blob/main/src/tick/core.cljc#L796-L799">Source</a></sub></p>

## <a name="tick.core/reset-vals!">`reset-vals!`</a>
``` clojure
(reset-vals! at newval)
```
Function.

reset-vals! on atomic clock 'at' 
<p><sub><a href="/blob/main/src/tick/core.cljc#L801-L804">Source</a></sub></p>

## <a name="tick.core/reverse-unit-map">`reverse-unit-map`</a>



<p><sub><a href="/blob/main/src/tick/core.cljc#L580-L581">Source</a></sub></p>

## <a name="tick.core/second">`second`</a>
``` clojure
(second t)
```
Function.

extract second from t
<p><sub><a href="/blob/main/src/tick/core.cljc#L1272-L1272">Source</a></sub></p>

## <a name="tick.core/seconds">`seconds`</a>
``` clojure
(seconds v)
```
Function.

extract seconds from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1533-L1533">Source</a></sub></p>

## <a name="tick.core/swap!">`swap!`</a>
``` clojure
(swap! at f & args)
```
Function.

swap! on atomic clock 'at' 
<p><sub><a href="/blob/main/src/tick/core.cljc#L778-L781">Source</a></sub></p>

## <a name="tick.core/swap-vals!">`swap-vals!`</a>
``` clojure
(swap-vals! at f & args)
```
Function.

swap-vals! on atomic clock 'at' 
<p><sub><a href="/blob/main/src/tick/core.cljc#L783-L786">Source</a></sub></p>

## <a name="tick.core/tick-resolution">`tick-resolution`</a>
``` clojure
(tick-resolution clk)
(tick-resolution clk dur)
```
Function.

Obtains a clock that returns instants from the specified clock truncated to the nearest occurrence of the specified duration.
<p><sub><a href="/blob/main/src/tick/core.cljc#L739-L744">Source</a></sub></p>

## <a name="tick.core/time">`time`</a>
``` clojure
(time)
(time v)
```
Function.

extract time from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1278-L1281">Source</a></sub></p>

## <a name="tick.core/time?">`time?`</a>
``` clojure
(time? v)
```
Function.

true if v is a time?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1129-L1129">Source</a></sub></p>

## <a name="tick.core/today">`today`</a>
``` clojure
(today)
```
Function.

same as (t/date)
<p><sub><a href="/blob/main/src/tick/core.cljc#L106-L107">Source</a></sub></p>

## <a name="tick.core/tomorrow">`tomorrow`</a>
``` clojure
(tomorrow)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L914-L915">Source</a></sub></p>

## <a name="tick.core/truncate">`truncate`</a>
``` clojure
(truncate x u)
```
Function.

Returns a copy of x truncated to the specified unit.
<p><sub><a href="/blob/main/src/tick/core.cljc#L613-L617">Source</a></sub></p>

## <a name="tick.core/unit-map">`unit-map`</a>




keyword to chrono-unit
<p><sub><a href="/blob/main/src/tick/core.cljc#L561-L578">Source</a></sub></p>

## <a name="tick.core/units">`units`</a>
``` clojure
(units x)
```
Function.

the units contained within TemporalAmount x.
  
  Seconds and nanos for Duration.
  Years, months, days for Period
  
<p><sub><a href="/blob/main/src/tick/core.cljc#L583-L594">Source</a></sub></p>

## <a name="tick.core/with">`with`</a>
``` clojure
(with t adj)
(with t fld new-value)
```
Function.

Adjust a temporal with an adjuster or field
<p><sub><a href="/blob/main/src/tick/core.cljc#L497-L503">Source</a></sub></p>

## <a name="tick.core/with-clock">`with-clock`</a>
``` clojure
(with-clock clock & body)
```
Macro.

temporarily change ambient now+zone info 
   the given 'clock' could be an Instant, zone or zoned-date-time
<p><sub><a href="/blob/main/src/tick/core.cljc#L1313-L1318">Source</a></sub></p>

## <a name="tick.core/year">`year`</a>
``` clojure
(year)
(year v)
```
Function.

extract year from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1298-L1301">Source</a></sub></p>

## <a name="tick.core/year-month">`year-month`</a>
``` clojure
(year-month)
(year-month v)
```
Function.

extract year-month from v
<p><sub><a href="/blob/main/src/tick/core.cljc#L1303-L1306">Source</a></sub></p>

## <a name="tick.core/year-month?">`year-month?`</a>
``` clojure
(year-month? v)
```
Function.

true if v is a year-month?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1134-L1134">Source</a></sub></p>

## <a name="tick.core/year?">`year?`</a>
``` clojure
(year? v)
```
Function.

true if v is a year?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1133-L1133">Source</a></sub></p>

## <a name="tick.core/years">`years`</a>
``` clojure
(years v)
```
Function.

extract years from 'v'
<p><sub><a href="/blob/main/src/tick/core.cljc#L1538-L1538">Source</a></sub></p>

## <a name="tick.core/yesterday">`yesterday`</a>
``` clojure
(yesterday)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L917-L918">Source</a></sub></p>

## <a name="tick.core/zone">`zone`</a>
``` clojure
(zone)
(zone z)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L194-L196">Source</a></sub></p>

## <a name="tick.core/zone-offset">`zone-offset`</a>
``` clojure
(zone-offset offset)
(zone-offset hours minutes)
(zone-offset hours minutes seconds)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L198-L201">Source</a></sub></p>

## <a name="tick.core/zone-offset?">`zone-offset?`</a>
``` clojure
(zone-offset? v)
```
Function.

true if v is a zone-offset?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1136-L1136">Source</a></sub></p>

## <a name="tick.core/zone?">`zone?`</a>
``` clojure
(zone? v)
```
Function.

true if v is a zone?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1135-L1135">Source</a></sub></p>

## <a name="tick.core/zoned-date-time">`zoned-date-time`</a>
``` clojure
(zoned-date-time)
(zoned-date-time v)
```
Function.
<p><sub><a href="/blob/main/src/tick/core.cljc#L1199-L1201">Source</a></sub></p>

## <a name="tick.core/zoned-date-time?">`zoned-date-time?`</a>
``` clojure
(zoned-date-time? v)
```
Function.

true if v is a zoned-date-time?
<p><sub><a href="/blob/main/src/tick/core.cljc#L1137-L1137">Source</a></sub></p>

-----
# <a name="tick.protocols">tick.protocols</a>






## <a name="tick.protocols/+">`+`</a>
``` clojure
(+ t d)
```
Function.

Sum amounts of time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L76-L76">Source</a></sub></p>

## <a name="tick.protocols/-">`-`</a>
``` clojure
(- t d)
```
Function.

Subtract from amount of time, or negate
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L77-L77">Source</a></sub></p>

## <a name="tick.protocols/<">`<`</a>
``` clojure
(< x y)
```
Function.

Is x before y?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L66-L66">Source</a></sub></p>

## <a name="tick.protocols/<=">`<=`</a>
``` clojure
(<= x y)
```
Function.

Is x before or at the same time as y?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L67-L67">Source</a></sub></p>

## <a name="tick.protocols/=">`=`</a>
``` clojure
(= x y)
```
Function.

Is x the same point on the timeline as y?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L65-L65">Source</a></sub></p>

## <a name="tick.protocols/>">`>`</a>
``` clojure
(> x y)
```
Function.

Is x after y?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L68-L68">Source</a></sub></p>

## <a name="tick.protocols/>=">`>=`</a>
``` clojure
(>= x y)
```
Function.

Is x after or at the same time as y?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L69-L69">Source</a></sub></p>

## <a name="tick.protocols/ibetween">`IBetween`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L79-L80">Source</a></sub></p>

## <a name="tick.protocols/iclock">`IClock`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L85-L86">Source</a></sub></p>

## <a name="tick.protocols/iconversion">`IConversion`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L58-L62">Source</a></sub></p>

## <a name="tick.protocols/idivisible">`IDivisible`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L48-L49">Source</a></sub></p>

## <a name="tick.protocols/idivisibleduration">`IDivisibleDuration`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L51-L52">Source</a></sub></p>

## <a name="tick.protocols/iextraction">`IExtraction`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L88-L106">Source</a></sub></p>

## <a name="tick.protocols/ilocaltime">`ILocalTime`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L82-L83">Source</a></sub></p>

## <a name="tick.protocols/iparseable">`IParseable`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L15-L37">Source</a></sub></p>

## <a name="tick.protocols/itimearithmetic">`ITimeArithmetic`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L75-L77">Source</a></sub></p>

## <a name="tick.protocols/itimecomparison">`ITimeComparison`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L64-L69">Source</a></sub></p>

## <a name="tick.protocols/itimelength">`ITimeLength`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L108-L117">Source</a></sub></p>

## <a name="tick.protocols/itimerangeable">`ITimeRangeable`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L45-L46">Source</a></sub></p>

## <a name="tick.protocols/itimereify">`ITimeReify`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L9-L13">Source</a></sub></p>

## <a name="tick.protocols/itimeshift">`ITimeShift`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L39-L43">Source</a></sub></p>

## <a name="tick.protocols/itimespan">`ITimeSpan`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L54-L56">Source</a></sub></p>

## <a name="tick.protocols/itruncate">`ITruncate`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L6-L7">Source</a></sub></p>

## <a name="tick.protocols/minmax">`MinMax`</a>



<p><sub><a href="/blob/main/src/tick/protocols.cljc#L71-L73">Source</a></sub></p>

## <a name="tick.protocols/at">`at`</a>
``` clojure
(at date time)
```
Function.

Set date to be AT a time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L11-L11">Source</a></sub></p>

## <a name="tick.protocols/backward-duration">`backward-duration`</a>
``` clojure
(backward-duration _ d)
```
Function.

Decrement time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L43-L43">Source</a></sub></p>

## <a name="tick.protocols/backward-number">`backward-number`</a>
``` clojure
(backward-number _ n)
```
Function.

Decrement time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L42-L42">Source</a></sub></p>

## <a name="tick.protocols/beginning">`beginning`</a>
``` clojure
(beginning _)
```
Function.

Return the beginning of a span of time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L55-L55">Source</a></sub></p>

## <a name="tick.protocols/between">`between`</a>
``` clojure
(between v1 v2)
```
Function.

Return the duration (or period) between two times
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L80-L80">Source</a></sub></p>

## <a name="tick.protocols/clock">`clock`</a>
``` clojure
(clock _)
```
Function.

Make a clock
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L86-L86">Source</a></sub></p>

## <a name="tick.protocols/date">`date`</a>
``` clojure
(date _)
```
Function.

Make a java.time.LocalDate instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L90-L90">Source</a></sub></p>

## <a name="tick.protocols/date-time">`date-time`</a>
``` clojure
(date-time _)
```
Function.

Make a java.time.LocalDateTime instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L91-L91">Source</a></sub></p>

## <a name="tick.protocols/day-of-month">`day-of-month`</a>
``` clojure
(day-of-month _)
```
Function.

Return value of the day in the month as an integer.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L99-L99">Source</a></sub></p>

## <a name="tick.protocols/day-of-week">`day-of-week`</a>
``` clojure
(day-of-week _)
```
Function.

Make a java.time.DayOfWeek instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L98-L98">Source</a></sub></p>

## <a name="tick.protocols/days">`days`</a>
``` clojure
(days _)
```
Function.

Return the given quantity in days.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L115-L115">Source</a></sub></p>

## <a name="tick.protocols/divide">`divide`</a>
``` clojure
(divide t divisor)
```
Function.

Divide time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L49-L49">Source</a></sub></p>

## <a name="tick.protocols/divide-duration">`divide-duration`</a>
``` clojure
(divide-duration divisor duration)
```
Function.

Divide a duration
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L52-L52">Source</a></sub></p>

## <a name="tick.protocols/end">`end`</a>
``` clojure
(end _)
```
Function.

Return the end of a span of time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L56-L56">Source</a></sub></p>

## <a name="tick.protocols/forward-duration">`forward-duration`</a>
``` clojure
(forward-duration _ d)
```
Function.

Increment time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L41-L41">Source</a></sub></p>

## <a name="tick.protocols/forward-number">`forward-number`</a>
``` clojure
(forward-number _ n)
```
Function.

Increment time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L40-L40">Source</a></sub></p>

## <a name="tick.protocols/hour">`hour`</a>
``` clojure
(hour _)
```
Function.

Return the hour field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L97-L97">Source</a></sub></p>

## <a name="tick.protocols/hours">`hours`</a>
``` clojure
(hours _)
```
Function.

Return the given quantity in hours.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L114-L114">Source</a></sub></p>

## <a name="tick.protocols/in">`in`</a>
``` clojure
(in dt zone)
```
Function.

Set a date-time to be in a time-zone
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L12-L12">Source</a></sub></p>

## <a name="tick.protocols/inst">`inst`</a>
``` clojure
(inst _)
```
Function.

Make a java.util.Date or js/Date instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L59-L59">Source</a></sub></p>

## <a name="tick.protocols/instant">`instant`</a>
``` clojure
(instant _)
```
Function.

Make a java.time.Instant instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L60-L60">Source</a></sub></p>

## <a name="tick.protocols/int">`int`</a>
``` clojure
(int _)
```
Function.

Return value as integer
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L100-L100">Source</a></sub></p>

## <a name="tick.protocols/local?">`local?`</a>
``` clojure
(local? t)
```
Function.

Is the time a java.time.LocalTime or java.time.LocalDateTime?
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L83-L83">Source</a></sub></p>

## <a name="tick.protocols/long">`long`</a>
``` clojure
(long _)
```
Function.

Return value as long
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L101-L101">Source</a></sub></p>

## <a name="tick.protocols/max-of-type">`max-of-type`</a>
``` clojure
(max-of-type _)
```
Function.

Return the max
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L73-L73">Source</a></sub></p>

## <a name="tick.protocols/micros">`micros`</a>
``` clojure
(micros _)
```
Function.

Return the given quantity in microseconds.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L110-L110">Source</a></sub></p>

## <a name="tick.protocols/microsecond">`microsecond`</a>
``` clojure
(microsecond _)
```
Function.

Return the millisecond field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L93-L93">Source</a></sub></p>

## <a name="tick.protocols/millis">`millis`</a>
``` clojure
(millis _)
```
Function.

Return the given quantity in milliseconds.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L111-L111">Source</a></sub></p>

## <a name="tick.protocols/millisecond">`millisecond`</a>
``` clojure
(millisecond _)
```
Function.

Return the millisecond field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L94-L94">Source</a></sub></p>

## <a name="tick.protocols/min-of-type">`min-of-type`</a>
``` clojure
(min-of-type _)
```
Function.

Return the min
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L72-L72">Source</a></sub></p>

## <a name="tick.protocols/minute">`minute`</a>
``` clojure
(minute _)
```
Function.

Return the minute field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L96-L96">Source</a></sub></p>

## <a name="tick.protocols/minutes">`minutes`</a>
``` clojure
(minutes _)
```
Function.

Return the given quantity in minutes.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L113-L113">Source</a></sub></p>

## <a name="tick.protocols/month">`month`</a>
``` clojure
(month _)
```
Function.

Make a java.time.Month instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L102-L102">Source</a></sub></p>

## <a name="tick.protocols/months">`months`</a>
``` clojure
(months _)
```
Function.

Return the given quantity in months.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L116-L116">Source</a></sub></p>

## <a name="tick.protocols/nanos">`nanos`</a>
``` clojure
(nanos _)
```
Function.

Return the given quantity in nanoseconds.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L109-L109">Source</a></sub></p>

## <a name="tick.protocols/nanosecond">`nanosecond`</a>
``` clojure
(nanosecond _)
```
Function.

Return the millisecond field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L92-L92">Source</a></sub></p>

## <a name="tick.protocols/offset-by">`offset-by`</a>
``` clojure
(offset-by dt amount)
```
Function.

Set a date-time to be offset by an amount
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L13-L13">Source</a></sub></p>

## <a name="tick.protocols/offset-date-time">`offset-date-time`</a>
``` clojure
(offset-date-time _)
```
Function.

Make a java.time.OffsetDateTime instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L61-L61">Source</a></sub></p>

## <a name="tick.protocols/on">`on`</a>
``` clojure
(on time date)
```
Function.

Set time be ON a date
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L10-L10">Source</a></sub></p>

## <a name="tick.protocols/parse">`parse`</a>
``` clojure
(parse _)
```
Function.


    Parse is not in the main api because it is slow and may give surprising behaviour.
    
    Various tick functions in the public api  (e.g between) still accept strings as arguments and will attempt
    to parse the args into an applicable date/time entity before carrying out the main work of the 
    function. Calling these functions with strings is not recommended but has been kept for backward
    compatibility.
    
    Parse to most applicable instance. 
    
    Do not use this function if you know the expected format of the string
that you want to parse. This is partly because for example t/instant, t/date etc  will
be much faster, but also because if the string you pass it is not in the format you
expect, this function may still convert it into some entity that you weren't expecting.

If you have a string in a non-standard format, use a formatter and the parse fn of they entity you want.

For example:

(cljc.java-time.local-date/parse "20200202" (t/formatter "yyyyMMdd"))

<p><sub><a href="/blob/main/src/tick/protocols.cljc#L16-L37">Source</a></sub></p>

## <a name="tick.protocols/range">`range`</a>
``` clojure
(range from)
(range from to)
(range from to step)
```
Function.

Returns a lazy seq of times from start (inclusive) to end (exclusive, nil means forever), by step, where start defaults to 0, step to 1, and end to infinity.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L46-L46">Source</a></sub></p>

## <a name="tick.protocols/second">`second`</a>
``` clojure
(second _)
```
Function.

Return the second field of the given time
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L95-L95">Source</a></sub></p>

## <a name="tick.protocols/seconds">`seconds`</a>
``` clojure
(seconds _)
```
Function.

Return the given quantity in seconds.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L112-L112">Source</a></sub></p>

## <a name="tick.protocols/time">`time`</a>
``` clojure
(time _)
```
Function.

Make a java.time.LocalTime instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L89-L89">Source</a></sub></p>

## <a name="tick.protocols/truncate">`truncate`</a>
``` clojure
(truncate date-time unit-kw)
```
Function.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L7-L7">Source</a></sub></p>

## <a name="tick.protocols/year">`year`</a>
``` clojure
(year _)
```
Function.

Make a java.time.Year instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L103-L103">Source</a></sub></p>

## <a name="tick.protocols/year-month">`year-month`</a>
``` clojure
(year-month _)
```
Function.

Make a java.time.YearMonth instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L104-L104">Source</a></sub></p>

## <a name="tick.protocols/years">`years`</a>
``` clojure
(years _)
```
Function.

Return the given quantity in years.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L117-L117">Source</a></sub></p>

## <a name="tick.protocols/zone">`zone`</a>
``` clojure
(zone _)
```
Function.

Make a java.time.ZoneId instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L105-L105">Source</a></sub></p>

## <a name="tick.protocols/zone-offset">`zone-offset`</a>
``` clojure
(zone-offset _)
```
Function.

Make a java.time.ZoneOffset instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L106-L106">Source</a></sub></p>

## <a name="tick.protocols/zoned-date-time">`zoned-date-time`</a>
``` clojure
(zoned-date-time _)
```
Function.

Make a java.time.ZonedDateTime instance.
<p><sub><a href="/blob/main/src/tick/protocols.cljc#L62-L62">Source</a></sub></p>
