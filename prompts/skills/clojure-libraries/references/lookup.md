# Lookup

Testing helpers for Hiccup-like data. Use Lookup when a test needs to find the relevant nodes in rendered Hiccup, assert on text/attributes/children, or normalize noisy Hiccup before comparing it.

Lookup is small, dependency-free, and implemented as `.cljc` for Clojure and ClojureScript.

## Setup

deps.edn:
```clojure
no.cjohansen/lookup {:mvn/version "2026.07.1"}
```

Leiningen:
```clojure
[no.cjohansen/lookup "2026.07.1"]
```

Require:
```clojure
(require '[lookup.core :as lookup])
```

See https://clojars.org/no.cjohansen/lookup for the latest version.

## Quick Start

```clojure
(require '[clojure.test :refer [is]]
         '[lookup.core :as lookup])

(def hiccup
  [:div
   [:ul
    nil
    [:li "B1"]
    [:li.active
     [:a {:href "#"} "C"]]
    [:li "D1"]]
   [:h1 "Heading"]
   [:p "Paragraph"]])

(lookup/select '[ul > li a] hiccup)
;; => [[:a {:href "#"} "C"]]

(-> (lookup/select-one 'li.active hiccup)
    lookup/text)
;; => "C"

(is (= "Heading"
       (-> (lookup/select-one 'h1 hiccup) lookup/text)))
```

## Core API

```clojure
(lookup/select selector hiccup)
;; Returns all matching nodes as a seq. If `hiccup` is a collection of nodes,
;; searches each node and concatenates the matches.

(lookup/select-one selector hiccup)
;; Returns the first matching node, or nil.

(lookup/normalize-hiccup hiccup)
(lookup/normalize-hiccup hiccup {:strip-empty-attrs? true})
;; Normalizes Hiccup shape for easier assertions/manipulation.

(lookup/attrs node)
;; Returns the node's attribute map, or nil if no attribute map is present.

(lookup/children node)
;; Returns normalized direct children.

(lookup/first-child node)
(lookup/last-child node)

(lookup/text hiccup)
(lookup/get-text hiccup) ; backwards-compatible alias
;; Extracts text from one node or a collection of nodes.
```

## Selectors

Lookup supports CSS-like selectors expressed as Clojure data. A single selector can be a symbol, keyword, or string. Use a vector for descendant/child/sibling paths.

```clojure
(lookup/select 'a hiccup)                 ; all <a> nodes
(lookup/select '[form input] hiccup)      ; input descendants of form
(lookup/select '[form > input] hiccup)    ; direct child inputs
(lookup/select '[h1 + p] hiccup)          ; adjacent sibling p after h1
(lookup/select '[h1 "~" p] hiccup)       ; subsequent sibling p after h1
```

Use string selectors when the Clojure reader would make symbols awkward, especially attribute selectors and id-only selectors:

```clojure
(lookup/select 'div.foo hiccup)                 ; tag + class
(lookup/select ".button" hiccup)               ; class-only selector
(lookup/select "#content" hiccup)              ; id-only selector
(lookup/select "meta[property]" hiccup)        ; attribute present
(lookup/select "meta[property=og:title]" hiccup)
```

Supported selector features:

- Tags: `'a`, `:div`, namespaced tags like `:ui/button`, `'ui/button`, or `"ui.elements/button"`.
- Wildcard: `'*` or `"*"`.
- Classes: `'div.foo`, `".button"`; class attrs may be strings, keywords, or collections.
- IDs: `"#app"`, `:div#app`, `"div#app"`.
- Attributes: `[attr]`, `[attr=value]`, plus CSS attribute operators `~=`, `|=`, `^=`, `$=`, `*=`.
- Pseudo-classes: `:first-child`, `:last-child`.
- Function selector: `:has(...)` for descendants/subselectors, e.g. `"li:has(a)"`.
- Custom selector: `:contains` for values found in a node's content subtree.

### `:has(...)`

```clojure
(lookup/select "li:has(a)" hiccup)
;; => li nodes that contain an a descendant

(lookup/select "ul:has(li + li.active)" hiccup)
;; => ul nodes that have an li followed by an active li

(lookup/select "ul:has(li.active)" hiccup)
;; => ul nodes that contain an active li
```

### `:contains`

`:contains` checks child-node content, not tag names or attributes. Because it searches the entire subtree, an unqualified `:contains` selector also matches ancestors on the path to the matching value.

```clojure
(lookup/select '[div [:contains "Heading"]] hiccup)
;; => matching descendants under div whose subtree contains "Heading"

(lookup/select [[:h1 :contains "Heading"]] hiccup)
;; => only h1 nodes containing "Heading"

(lookup/select [[:contains "Heading"]] hiccup)
;; => matching node and its ancestors, if their subtrees contain "Heading"
```

## Normalizing Hiccup

`normalize-hiccup` makes flexible Hiccup data easier to compare:

- Ensures Hiccup nodes have an attribute map, unless `:strip-empty-attrs? true` elides empty maps.
- Parses tag shorthand such as `:div#main.active` into tag + attributes.
- Merges classes from tag shorthand and `:class` attributes.
- Converts classes to sets of class names.
- Flattens nested seqs/lists of children.
- Removes `nil` children.
- Leaves attribute values alone, including maps and Hiccup-like tuples in attributes.

```clojure
(lookup/normalize-hiccup
 [:div#main
  [:ul
   nil
   [:li {} "One"]
   [:li.active {:class "selected"}
    [:a {:href "#"} "Two"]]
   '([:li "Three"])]])
;; =>
;; [:div {:id "main"}
;;  [:ul {}
;;   [:li {} "One"]
;;   [:li {:class #{"active" "selected"}}
;;    [:a {:href "#"} "Two"]]
;;   [:li {} "Three"]]]

(lookup/normalize-hiccup
 [:div [:p "Text"]]
 {:strip-empty-attrs? true})
;; => [:div [:p "Text"]]
```

## Text Extraction

`text` walks Hiccup and joins textual content with spaces. It works on a single node or a collection of nodes.

```clojure
(lookup/text [:h1 "Hello world"])
;; => "Hello world"

(->> hiccup
     (lookup/select '[ul > li])
     lookup/text)
;; => "B1 C D1"
```

## Testing Patterns

```clojure
(is (= "Save"
       (-> (lookup/select-one "button[type=submit]" view)
           lookup/text)))

(is (= {:href "/users/1"}
       (-> (lookup/select-one 'a.user-link view)
           lookup/attrs
           (select-keys [:href]))))

(is (= 3 (count (lookup/select '.item view))))

(is (= ["One" "Two"]
       (->> (lookup/select '[ul > li] view)
            (map lookup/text))))
```

## Gotchas / Caveats

1. Lookup does not parse full CSS selector strings with spaces like `"ul > li"`. Use vector form: `'[ul > li]`.
2. `select` returns normalized nodes: classes are sets, ids/classes from tag shorthand move into attrs, nested child seqs are flattened, nil children are removed, and empty attr maps may be stripped.
3. `:contains` ignores attributes and tag names; it searches child-node content only.
4. Attribute matching stringifies values, so keywords can match their string form (including namespaces).
5. Hiccup nodes are vectors whose first element is a keyword. Hiccup-like tuples inside attribute maps are treated as attribute data, not child nodes.
6. `:has(a, b)` parses, but current matching requires each listed selector to match; avoid comma-separated `:has` unless you want all of them.

## References

- GitHub: https://github.com/cjohansen/lookup
- Source and README: available through the `local-git-reference` skill (`github.com/cjohansen/lookup`).
