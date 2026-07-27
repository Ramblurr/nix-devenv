# Standards Review Template

## Mandatory Delivery Contract

Report path: `{REPORT_PATH}`

The review is read-only with respect to implementation files, generated files, Git staging, and commits. Writing the complete, self-contained report at the path above is required and is the only permitted file change.

Never return the review body through agent chat or a link callback. The only review reference sent between agents is its file path.

**Link delivery is strict:** after the report exists on disk, use `link_send(triggerTurn:true)` to send exactly one of:

`APPROVE {REPORT_PATH}`

`CHANGES-NEEDED {REPORT_PATH}`

If the report cannot be written, send:

`BLOCKED <reason>`

Never substitute an inline review for the report or include review findings in the Link message.

<standards-review-template>

# Standards Review

**Fixed point:** <commit, branch, tag, or merge-base>
**Head:** <reviewed head>

## Findings

<For each finding, use:>

### <temporary finding ID>. <finding title>

- **Severity:** <Critical / Important / Minor / Judgement call>
- **Location:** <file and line or hunk>
- **Evidence:** <the violated documented rule or named smell>
- **Impact:** <why it matters>
- **Recommendation:** <how to address it>

<If there are no findings, write "No findings.">

## Axis Summary

- Findings: <count>
- Worst issue: <temporary finding ID and title, or "None">

## Assessment

Verdict: <APPROVE / CHANGES-NEEDED>

Reasoning: <one or two sentences>

</standards-review-template>

Use temporary finding IDs `S1`, `S2`, and so on. The coordinator replaces them with the final numeric sequence in the aggregate.
