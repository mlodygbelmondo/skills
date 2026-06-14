---
name: truth-review
description: "Verify whether reported issues, review comments, PRD concerns, model findings, or handoff claims are actually real. Use when the user asks to double-check, verify issues, confirm whether findings are real, detect overengineering, review only important bugs, or decide whether a reported problem needs action."
---

# Truth Review

Use this skill as a read-only verification pass for claims made by another model, reviewer, PRD, handoff, or bug report.

## Core Rule

If you are not sure whether a finding is real, reproducible, in scope, or worth acting on, say that and ask the user for the missing evidence. Do not inflate uncertainty into a confident recommendation.

## Default Posture

- Stay read-only unless the user explicitly asks you to fix confirmed findings.
- Prefer evidence over intuition.
- Prioritize real bugs, security issues, data loss, broken flows, performance regressions, and maintainability risks with clear future cost.
- De-prioritize style nits, speculative rewrites, and abstract "could be cleaner" feedback unless it blocks correctness or maintainability.

## Workflow

1. Understand the claim.
   - Read the supplied handoff, PRD, review comment, issue, or pasted finding in full.
   - Extract each concrete claim into a short checklist.
   - Separate actionable claims from vague concerns.

2. Gather evidence.
   - Read the relevant code and tests.
   - Use `rg` and focused file reads before forming conclusions.
   - Inspect git diff when reviewing uncommitted or branch-specific changes.
   - Run narrow commands only when they can directly verify or falsify a claim.

3. Classify each claim.
   - `real`: evidence shows the issue exists and matters.
   - `not real`: evidence contradicts the claim.
   - `uncertain`: evidence is incomplete, environment-dependent, or requires product clarification.
   - `overengineering`: the claim proposes complexity without a demonstrated problem.

4. Judge severity.
   - Treat user impact, production risk, security/privacy exposure, data loss, and testability as severity drivers.
   - Do not mark an issue severe just because the wording sounds dramatic.

5. Report findings first.
   - Lead with confirmed issues, ordered by severity.
   - Include file and line references when available.
   - Then list dismissed claims and why they were dismissed.
   - Then list open questions.

## Output Shape

Use concise Markdown:

1. Confirmed findings
2. Not real / overengineering
3. Uncertain / needs user decision
4. Verification performed

If there are no confirmed issues, say that clearly and mention residual risk.
