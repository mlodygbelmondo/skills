---
name: to-issues
description: Break a plan, spec, or PRD into independently-grabbable local issue markdown files under `.ai/issues/` using tracer-bullet vertical slices, and ensure `.ai/` is listed in `.gitignore`. Use when the user wants to convert a plan into local implementation tickets or break down work into issues.
---

# To Issues

Break a plan into independently-grabbable local issue files using vertical slices (tracer bullets).

## Local-only rule

Always write issues locally under `.ai/issues/`. Do not use network tools or any remote project-management tools for this skill.

Before writing any issue, ensure `.ai/` is listed in `.gitignore`. If `.gitignore` does not exist, create it with `.ai/`.

Local output:

- Directory: `.ai/issues/<feature-slug>/`
- File naming: `<NN>-<short-slice-slug>.md`, numbered from `01`
- Required frontmatter:

```yaml
---
status: ready-for-agent
title: <Human readable issue title>
created: YYYY-MM-DD
---
```

Always ensure `.ai/` is ignored in the current repo before or during issue creation. The `.ai/` directory is private local agent work product and must stay local.

## Process

### 1. Gather context

Work from whatever is already in the conversation context. If the user passes a local file path as an argument, read its full body and any comments or follow-up notes in the file.

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code. Issue titles and descriptions should use the project's domain glossary vocabulary, and respect ADRs in the area you're touching.

### 3. Draft vertical slices

Break the plan into **tracer bullet** issues. Each issue is a thin vertical slice that cuts through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

Slices may be `HITL` or `AFK`. HITL slices require human interaction, such as an architectural decision or a design review. AFK slices can be implemented without human interaction. Prefer AFK over HITL where possible.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

### 4. Quiz the user

Present the proposed breakdown as a numbered list. For each slice, show:

- **Title**: short descriptive name
- **Type**: HITL / AFK
- **Blocked by**: which other slices (if any) must complete first
- **User stories covered**: which user stories this addresses (if the source material has them)

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the dependency relationships correct?
- Should any slices be merged or split further?
- Are the correct slices marked as HITL and AFK?

Iterate until the user approves the breakdown.

### 5. Save local issue files

For each approved slice, write a new local markdown file under `.ai/issues/<feature-slug>/`. Use the issue body template below. These issues are considered ready for agents, so include `status: ready-for-agent` in frontmatter unless the slice is explicitly HITL.

Write issues in dependency order (blockers first) so later files can reference earlier local filenames in the "Blocked by" field.

<issue-template>

## Parent

A reference to the parent PRD or plan file, if one exists.

## What to build

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation.

Avoid specific file paths or code snippets — they go stale fast. Exception: if a prototype produced a snippet that encodes a decision more precisely than prose can (state machine, reducer, schema, type shape), inline it here and note briefly that it came from a prototype. Trim to the decision-rich parts — not a working demo, just the important bits.

## Acceptance criteria

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Blocked by

- A reference to the blocking local issue file, if any

Or "None - can start immediately" if no blockers.

</issue-template>

Do NOT close or modify any parent PRD or plan file unless the user explicitly asks.
