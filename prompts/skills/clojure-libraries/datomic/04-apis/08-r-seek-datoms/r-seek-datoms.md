<a id="content"></a>

<a id="r-seek-datoms"></a>

# (r)seek-datoms

The Peer API provides index access to raw datoms via `seek-datoms` and its reverse complement `rseek-datoms`.

There are two concepts you need to understand when using (r)seek-datoms: seek and consume. You say where to seek and (r)seek-datoms will return datoms in the respective direction from that point in the specified index. It will continue conveying datoms lazily until either you stop consuming them or you reach the end of the index. All database values and indexes are supported.

<a id="outline-container-seek-datoms"></a>

<a id="seek-datoms"></a>

## seek-datoms

<a id="text-seek-datoms"></a>

`(seek-datoms db index & components)`

Returns datoms forward from the point in the index where the components would reside.

<a id="outline-container-rseek-datoms"></a>

<a id="rseek-datoms"></a>

## rseek-datoms

<a id="text-rseek-datoms"></a>

`(rseek-datoms db index & components)`

Returns datoms backward from the point in the index where the components would reside.

<a id="outline-container-seek-position"></a>

<a id="seek-position"></a>

## Seek Position

<a id="text-seek-position"></a>

You say where to seek by supplying one or more components of a datom in index-sort order. Regardless of whether the supplied datom exists, `seek-datoms` will start before the lowest match and `rseek-datoms` after the highest.

The following pictures illustrate different aspects of seek positioning.

\[Missing image: rseek-datoms1-attr-only.png (not an image asset: .html)\]

Each additional component specifies a more precise position in the index.

\[Missing image: rseek-datoms2-attr-value.png (not an image asset: .html)\]

\[Missing image: rseek-datoms3-tuple-value.png (not an image asset: .html)\]

When the supplied component does not exist in the index, both APIs start at the same point.

\[Missing image: rseek-datoms4-value-not-in-index.png (not an image asset: .html)\]

\[Missing image: rseek-datoms5-partial-tuple.png (not an image asset: .html)\]

When multiple entities possess the same value, `seek-datoms` starts before the lowest one and `rseek-datoms` after the highest.

\[Missing image: rseek-datoms6-multiple-entities-same-value.png (not an image asset: .html)\]
