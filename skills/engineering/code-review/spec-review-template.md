# Spec Review Template

## Mandatory Delivery Contract

Report path: `{REPORT_PATH}`

The review is read-only except for writing the complete Org mode report at that path. Never return the body through agent chat or a Link callback.

After the report exists, use `link_send(triggerTurn:true)` to send exactly `APPROVE {REPORT_PATH}` or `CHANGES-NEEDED {REPORT_PATH}`. If it cannot be written, send `BLOCKED <reason>`.

<spec-review-template>

```org
#+title: Spec Review

* Metadata
- Fixed point :: <commit, branch, tag, or merge-base>
- Head :: <reviewed head>
- Spec :: <path or issue reference>

* Findings
<For each finding, use:>

** <temporary finding ID>. <finding title>
- Severity :: <Critical / Important / Minor / Judgement call>
- Location :: <file and line or hunk>
- Evidence :: <the relevant spec requirement>
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

</spec-review-template>

Use temporary finding IDs `P1`, `P2`, and so on. The coordinator replaces them with the final numeric sequence in the aggregate.
