---
name: prd-implementation-auditor
description: "Audit a PRD, plan, or local `.ai/prd/` document against the current implementation. Use when the user asks whether a PRD is complete, which PRD is better, whether implementation matches a PRD, to review a PRD before implementation, or to verify and fix PRD gaps."
---

# PRD Implementation Auditor

Use this skill to compare intended behavior against actual code.

## Core Rule

If the PRD is ambiguous, stale, missing acceptance criteria, or conflicts with the codebase, ask the user before inventing product decisions. Do not silently fill in requirements that could change behavior.

## Local-First Rule

Treat PRDs, plans, and implementation issues as local working files. Prefer `.ai/prd/`, `.ai/issues/`, and `.ai/docs/plans/`. Do not create GitHub, Linear, Jira, or remote tracker artifacts unless the user explicitly asks.

## Audit Workflow

1. Read the source material.
   - Read the PRD or plan in full.
   - If multiple PRDs are supplied, summarize the intent and tradeoffs of each before choosing.
   - Extract requirements, acceptance criteria, out-of-scope items, data/schema expectations, and testing expectations.

2. Explore the implementation.
   - Read relevant repo instructions first.
   - Use `rg` to map requirements to code, tests, routes, migrations, API contracts, UI states, and background jobs.
   - Check whether there are existing patterns or canonical helpers that the implementation should reuse.

3. Build a requirement matrix.
   - `implemented`: code appears to satisfy the requirement.
   - `partially implemented`: code covers part of the behavior but misses cases or tests.
   - `missing`: no implementation found.
   - `contradicted`: implementation conflicts with the PRD.
   - `stale PRD`: the PRD describes behavior no longer aligned with current code or product direction.

4. Review quality and tests.
   - Check whether implementation stays in the right layer.
   - Check whether tests cover user-visible behavior and important failure modes.
   - Flag gaps that could cause regressions, not just missing paperwork.

5. Fix only when asked.
   - If the user asks to fix findings, implement confirmed gaps conservatively.
   - If a fix requires product judgment, ask first.
   - Keep `.ai/` local and gitignored unless the user explicitly wants otherwise.

## Output Shape

For an audit, report:

- Verdict: complete, incomplete, stale, or needs product decision
- Requirement matrix
- Confirmed gaps, ordered by risk
- Test gaps
- Open questions

For comparing PRDs, report:

- Which PRD is stronger
- Which one is safer to implement
- What should be merged from the weaker PRD
- Any user decisions needed before implementation
