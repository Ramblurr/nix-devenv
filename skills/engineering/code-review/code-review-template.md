# Aggregated Code Review Template

## Mandatory On-Disk Contract

Report path: `{REPORT_PATH}`

Write a complete Org mode aggregate to that path. Never return the review body through agent chat; return only the report path.

<code-review-report-template>

```org
#+title: Code Review

* Metadata
- Fixed point :: <commit, branch, tag, or merge-base>
- Head :: <reviewed head>
- Spec :: <path, issue reference, or "No spec available">
- Standards report :: <path>
- Spec report :: <path or "No spec report">

* Standards
<For each Standards finding, use:>

** <finding number>. <finding title>
- Severity :: <Critical / Important / Minor / Judgement call>
- Location :: <file and line or hunk>
- Evidence :: <the violated rule or smell>
- Impact :: <why it matters>
- Recommendation :: <how to address it>

<If there are no Standards findings, write "No findings.">

* Spec
<For each Spec finding, use:>

** <finding number>. <finding title>
- Severity :: <Critical / Important / Minor / Judgement call>
- Location :: <file and line or hunk>
- Evidence :: <the relevant spec requirement>
- Impact :: <why it matters>
- Recommendation :: <how to address it>

<If no spec exists, write "No spec available." If there are no Spec findings, write "No findings.">

* Summary
- Standards findings :: <count>
- Spec findings :: <count>
- Worst Standards issue :: <finding number and title, or "None">
- Worst Spec issue :: <finding number and title, or "None">

* Assessment
- Ready to merge :: <Yes / No / With fixes>
- Reasoning :: <one or two sentences>

* Progress
- [ ] TODO <finding number> <finding title>
```

</code-review-report-template>

Finding numbers form one sequence across the aggregate, starting at `1`: Standards first, then Spec. The Progress section must contain exactly one unchecked item with the same number and title for every finding. Findings without Progress entries, and Progress entries without findings, are invalid.

