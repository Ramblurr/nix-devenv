# Aggregated Code Review Template

## Mandatory On-Disk Contract

Report path: `{REPORT_PATH}`

Write the complete, self-contained aggregate to that path. Never return the review body through agent chat; return only the report path.

<code-review-report-template>

# Code Review

**Fixed point:** <commit, branch, tag, or merge-base>
**Head:** <reviewed head>
**Spec:** <path, issue reference, or "No spec available">
**Standards report:** <path>
**Spec report:** <path or "No spec report">

## Standards

<For each Standards finding, use:>

### <finding number>. <finding title>

- **Severity:** <Critical / Important / Minor / Judgement call>
- **Location:** <file and line or hunk>
- **Evidence:** <the violated rule or smell>
- **Impact:** <why it matters>
- **Recommendation:** <how to address it>

<If there are no Standards findings, write "No findings.">

## Spec

<For each Spec finding, use:>

### <finding number>. <finding title>

- **Severity:** <Critical / Important / Minor / Judgement call>
- **Location:** <file and line or hunk>
- **Evidence:** <the relevant spec requirement>
- **Impact:** <why it matters>
- **Recommendation:** <how to address it>

<If no spec exists, write "No spec available." If there are no Spec findings, write "No findings.">

## Summary

- Standards findings: <count>
- Spec findings: <count>
- Worst Standards issue: <finding number and title, or "None">
- Worst Spec issue: <finding number and title, or "None">

## Assessment

Ready to merge: <Yes / No / With fixes>

Reasoning: <one or two sentences>

## Progress

Labels: TODO, DONE, WONTFIX, DEFER

- [ ] TODO <finding number> <finding title>

</code-review-report-template>

Finding numbers form one sequence across the entire aggregate, starting at `1`. Number all Standards findings first, then continue that sequence through Spec findings. Never restart numbering for the second axis.

The Progress section must contain exactly one unchecked item for every finding, using the same number and title. Findings without Progress entries, and Progress entries without findings, are invalid.

