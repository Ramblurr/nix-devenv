# Shareable Logic Demo

Use a standalone HTML demo when a designer, product manager, domain expert, or other non-developer needs to explore a logic or state-model question. It is a communication artifact, not production code.

## Process

### 1. State the question visibly

Put the state model and the question being tested in a short introduction at the top of the page. A reader should know what the demo explores before pressing a button.

### 2. Keep the model small and pure

Use one inline script with a reducer, state machine, or small set of pure functions. Page rendering and button handlers call the model; the model does not touch the DOM. Use domain terms in every visible label.

For a Clojure implementation, retain the REPL/TUI prototype when exercising project code matters. The HTML demo records the agreed behavior; implement the validated behavior in the project language afterward.

### 3. Make one self-contained file

Use plain HTML, CSS, and JavaScript in one file. Do not add a framework, bundler, server, package, or persistence. The recipient opens the file directly in a browser.

Lay it out in this order:

1. Title and one-sentence explanation of the question.
2. A readable panel showing the full relevant state after each action.
3. Free-play buttons for every action.
4. Guided scenarios, each with a short explanation and ordered action buttons. Starting a scenario resets the state so it can be repeated.

Include a normal case, an awkward edge case, and an action that should be rejected when those cases matter to the question.

### 4. Hand it over and capture the answer

Open or send the file to the reviewer. Record the question, the conclusion, and any validated decision with the prototype as described in [SKILL.md](SKILL.md).

## Anti-patterns

- Raw JSON, code names, or developer-only labels instead of domain language.
- A framework, build step, or server for a one-file demo.
- Page handlers that contain the model logic.
- Promoting the HTML shell to production.
