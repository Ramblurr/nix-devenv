# Standards Review Template

## Mandatory Delivery Contract

Report path: `{REPORT_PATH}`

The review is read-only except for writing the complete Org mode report at that path. Never return the body through agent chat or a completion message.

After the report exists, return exactly `APPROVE {REPORT_PATH}` or `CHANGES-NEEDED {REPORT_PATH}` through the completion mechanism specified in your assignment. If it cannot be written, return `BLOCKED <reason>`.

<standards-review-template>

```org
#+title: Standards Review

* Metadata
- Fixed point :: <commit, branch, tag, or merge-base>
- Head :: <captured HEAD commit>
- Mode :: <committed / working-tree / staged-only>
- Inputs :: <absolute captured input manifest path>

* Findings
<For each finding, use:>

** <temporary finding ID>. <finding title>
- Severity :: <Critical / Important / Minor / Judgement call>
- Location :: <file and line or hunk>
- Evidence :: <the violated documented rule or named smell>
- Impact :: <why it matters>
- Recommendation :: <how to address it>

<If there are no findings, write "No findings.">

* Axis Summary
- Findings :: <count>
- Worst issue :: <temporary finding ID and title, or "None">

* Assessment
- Verdict :: <APPROVE / CHANGES-NEEDED>
- Reasoning :: <one or two sentences>
```

</standards-review-template>

Use temporary finding IDs `S1`, `S2`, and so on. The coordinator replaces them with the final numeric sequence in the aggregate.
