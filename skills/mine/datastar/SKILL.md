---
name: datastar
description: Build, debug, or review Datastar-backed web UI behavior, including data-* attributes, signals, backend-driven HTML patching, SSE responses, Datastar SDK usage, CQRS flows, and hypermedia-oriented frontend interactions.
---

# Datastar (d*)

Datastar is a small hypermedia-oriented frontend library built around `data-*` attributes, reactive signals, backend requests, and SSE-driven DOM/signal patching.

It overlaps with htmx by letting the backend drive HTML updates, and overlaps with Alpine.js by adding declarative frontend reactivity directly in HTML. It replaces both of them.

Unlike a full SPA framework, Datastar favors server-rendered markup, ordinary HTML navigation, and backend-owned state.

Prefer backend-driven UI updates.

Keep frontend signals small and purposeful.

Use backend reads for current state instead of preloading and trusting large frontend state snapshots.

Prefer ordinary page navigation with anchors and redirects unless the task explicitly needs a Datastar request.

Use actions for write-side behavior in CQRS-style Datastar flows.

Keep views thin.

Keep validation and write-side behavior on the backend.

## The Tao of Datastar

### State in the right place

Most state should live in the backend.

Since the frontend is exposed to the user, the backend should be the source of truth for application state.

### Start with the defaults

The default configuration options are the recommended settings for most applications.

Start with the defaults, and before changing them, stop and ask yourself, well... how did I get here?

### Patch elements and signals

Since the backend is the source of truth, it should drive the frontend by patching HTML elements and signals.

### Use signals sparingly

Overusing signals usually means you are managing too much state on the frontend.

Favor fetching current state from the backend rather than preloading state and assuming the frontend copy is still current.

A good rule of thumb is to use signals for user interactions, such as toggling element visibility, and for sending new state to the backend, such as binding signals to form inputs.

### In morph we trust

Morphing ensures that only modified parts of the DOM are updated, which preserves state and improves performance.

This makes it practical to send large chunks of the DOM tree, even up to the `html` tag, sometimes called “fat morph”, rather than managing fine-grained updates by hand.

If you need to explicitly ignore morphing for an element, use the [`data-ignore-morph`](https://data-star.dev/reference/attributes#data-ignore-morph) attribute.

### SSE responses

[SSE](https://html.spec.whatwg.org/multipage/server-sent-events.html) responses let you send `0` to `n` events that can [patch elements](https://data-star.dev/guide/getting_started/#patching-elements), [patch signals](https://data-star.dev/guide/reactive_signals#patching-signals), and [execute scripts](https://data-star.dev/guide/datastar_expressions#executing-scripts).

Since event streams are just HTTP responses with special formatting that [SDKs](https://data-star.dev/reference/sdks) can handle for you, there is usually no benefit to using a content type other than [`text/event-stream`](https://data-star.dev/reference/actions#response-handling).

### Compression

Since SSE responses stream events from the backend and morphing allows large DOM payloads, compression is a natural choice.

Compression ratios of 200:1 are not uncommon when compressing streams with Brotli.

See [this article](https://andersmurphy.com/2025/04/15/why-you-should-use-brotli-sse.html) for more on compressing streams.

### Backend templating

Since the backend generates the HTML, use your templating language to [keep things DRY](https://data-star.dev/how_tos/keep_datastar_code_dry).

### Page navigation

Page navigation has not changed in 30 years.

Use the [anchor element](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/a) to navigate to a new page, or use a [redirect](https://data-star.dev/how_tos/redirect_the_page_from_the_backend) when redirecting from the backend.

For smooth page transitions, use the [View Transition API](https://developer.mozilla.org/en-US/docs/Web/API/View_Transition_API).

### Browser history

Browsers already keep a history of visited pages.

If you start managing browser history yourself, you are adding complexity.

Each page is a resource.

Use anchor tags and let the browser do its job.

### CQRS

[CQRS](https://martinfowler.com/bliki/CQRS.html), where writes and reads are segregated, makes it possible to have a single long-lived request that receives updates from the backend while making multiple short-lived write requests to the backend.

It is a powerful pattern for real-time collaboration in Datastar.

```html
<div id="main" data-init="@get('/cqrs_endpoint')">
  <button data-on:click="@post('/do_something')">
    Do something
  </button>
</div>
```

### Loading indicators

Loading indicators tell the user that an action is in progress.

Use the [`data-indicator`](https://data-star.dev/reference/attributes#data-indicator) attribute to show a loading indicator on elements that trigger backend requests.

```html
<div>
  <button data-indicator:_loading
          data-on:click="@post('/do_something')">
    Do something
    <span data-show="$_loading">Loading...</span>
  </button>
</div>
```

When using [CQRS](https://data-star.dev/guide/the_tao_of_datastar#cqrs), it is often better to show a loading indicator manually when backend requests are made and hide it when the DOM is updated from the backend.

```html
<div>
  <button data-on:click="el.classList.add('loading'); @post('/do_something')">
    Do something
    <span>Loading...</span>
  </button>
</div>
```

### Optimistic updates

Optimistic updates, also called optimistic UI, update the interface immediately as if an operation succeeded before the backend confirms it.

That can make an app feel snappier, but it can also deceive the user.

Showing success first and then correcting it to failure a second later is worse than showing honest progress.

Prefer [loading indicators](https://data-star.dev/guide/the_tao_of_datastar#loading-indicators) while work is in progress, and only confirm success from the backend.

See [this example](https://data-star.dev/examples/rocket_flow).

### Accessibility

The web should be accessible to everyone.

Datastar stays out of your way and leaves [accessibility](https://developer.mozilla.org/en-US/docs/Web/Accessibility) to you.

Use semantic HTML, apply ARIA where it makes sense, and make sure the app works well with keyboards and screen readers.

```html
<button data-on:click="$_menuOpen = !$_menuOpen"
        data-attr:aria-expanded="$_menuOpen ? 'true' : 'false'">
  Open/Close Menu
</button>
<div data-attr:aria-hidden="$_menuOpen ? 'false' : 'true'"></div>
```

# Index

Use `./docs.md` when you need upstream Datastar syntax, attribute reference, action reference, SSE event formats, SDK examples, or behavior not covered here.
`./docs.md` is huge, so grep it first and read only the sections needed for the task.
An index of docs is below.

## Attributes

- `data-attr` - sets arbitrary HTML attribute values from expressions and keeps them in sync.
- `data-bind` - creates a signal and sets up 2 way data binding with the element.
- `data-class` - adds or removes class names based on expressions.
- `data-computed` - creates a read-only signal computed from an expression and updated when dependencies change.
- `data-effect` - runs an expression on initialization and whenever referenced signals change.
- `data-ignore` - tells Datastar not to process an element and, by default, its descendants.
- `data-ignore-morph` - tells patch-element morphing to skip an element and its children.
- `data-indicator` - creates a signal that is `true` while a fetch request is in flight.
- `data-init` - runs an expression when the attribute is initialized, patched into the DOM, or modified.
- `data-json-signals` - renders matching signals as reactive JSON for debugging.
- `data-on` - attaches an event listener and runs an expression when the event fires.
- `data-on-intersect` - runs an expression when the element intersects with the viewport.
- `data-on-interval` - runs an expression repeatedly at a configured interval.
- `data-on-signal-patch` - runs an expression whenever signals are patched.
- `data-on-signal-patch-filter` - filters which signal patches trigger `data-on-signal-patch`.
- `data-preserve-attr` - preserves specified attribute values while morphing DOM elements.
- `data-ref` - creates a signal that references the element.
- `data-show` - shows or hides an element based on a truthy or falsey expression.
- `data-signals` - patches one or more signals into the existing signal state.
- `data-style` - sets inline CSS style values from expressions and keeps them in sync.
- `data-text` - binds an element's text content to an expression.

### Pro Attributes

- `data-animate` - animates element attributes over time and updates reactively when signals change.
- `data-custom-validity` - sets an element's custom validity message from an expression.
- `data-match-media` - keeps a signal synced with whether a media query matches.
- `data-on-raf` - runs an expression on every `requestAnimationFrame` event.
- `data-on-resize` - runs an expression whenever an element's dimensions change.
- `data-persist` - persists matching signals in `localStorage` between page loads.
- `data-query-string` - syncs query string parameters and signal values.
- `data-replace-url` - replaces the browser URL without reloading the page.
- `data-scroll-into-view` - scrolls the element into view, often after backend DOM updates.
- `data-view-transition` - sets the `view-transition-name` style for View Transition API transitions.

### Related attribute reference topics

- Attribute Evaluation Order
- Attribute Casing
- Aliasing Attributes
- Datastar Expressions
- Error Handling

## Actions

- `@peek()` - reads signals without subscribing the current expression to their changes.
- `@setAll()` - sets all signals, or matching filtered signals, to a value.
- `@toggleAll()` - toggles all boolean signals, or matching filtered boolean signals.

### Backend Actions

- `@get()` - sends a `GET` request to the backend with signals and handles Datastar responses.
- `@post()` - works like `@get()` but sends a `POST` request.
- `@put()` - works like `@get()` but sends a `PUT` request.
- `@patch()` - works like `@get()` but sends a `PATCH` request.
- `@delete()` - works like `@get()` but sends a `DELETE` request.

### Related action reference topics

- Options
- Request Cancellation
- Response Handling
- Events

### Pro Actions

- `@clipboard()` - copies text to the clipboard, optionally decoding base64 first.
- `@fit()` - maps a number linearly from one range to another, with optional clamp and round behavior.
- `@intl()` - formats dates, numbers, and other values with JavaScript `Intl` formatters.

## SSE Events

- `datastar-patch-elements`
- `datastar-patch-signals`

# Security

Datastar expressions are JavaScript evaluated by Datastar with the JavaScript `Function()` constructor. Do not treat them as a security sandbox.

Treat expression strings and signal data as untrusted browser-side input.

Escape user input before inserting it into expressions or HTML.

Do not put user-controlled content in HTML `id` attributes.

Do not send secrets or sensitive data to the frontend (html, signals etc) at all that user's should have access to.

Always validate requests on the backend.

Use `data-ignore` on unsafe or externally controlled DOM subtrees that Datastar must not process.
