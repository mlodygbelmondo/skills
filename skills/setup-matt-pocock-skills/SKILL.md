---
name: setup-matt-pocock-skills
description: "Set up local-only agent skill conventions for this repo: `.ai/` work files, ready-for-agent metadata, and domain doc layout. Use before first use of `to-issues`, `to-prd`, `triage`, `diagnose`, `tdd`, `improve-codebase-architecture`, or `zoom-out` if those skills appear to be missing local project context."
---

# Setup Matt Pocock's Skills

Scaffold the per-repo configuration that the engineering skills assume:

- **Local work files** — PRDs, plans, and issues live under `.ai/`
- **Triage status vocabulary** — the strings used for local issue status metadata
- **Domain docs** — where `CONTEXT.md` and ADRs live, and the consumer rules for reading them

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Non-negotiable local-only rule

All PRDs, implementation issues, plans, and related agent work products are local files under `.ai/`.

Do not use network tools or any remote project-management tools from this skill. Save local files only.

Always ensure `.ai/` is listed in `.gitignore` before creating or updating local agent work files. If `.gitignore` does not exist, create it with `.ai/`. Treat `.ai/` as private local agent state that must not be committed or shared.

## Process

### 1. Explore

Look at the current repo to understand its starting state. Read whatever exists; don't assume:

- `AGENTS.md` and `CLAUDE.md` at the repo root — does either exist? Is there already an `## Agent skills` section in either?
- `.gitignore` — does it include `.ai/`? If it is missing, create it.
- `.ai/` — does it already contain `prd/`, `issues/`, or `docs/plans/`?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?

### 2. Present findings and ask

Summarise what's present and what's missing. Then walk the user through the remaining decisions **one at a time** — present a section, get the user's answer, then move to the next. Don't dump all sections at once.

Do not ask where issues or PRDs should go. The answer is always local `.ai/`.

**Section A — Local agent files.**

> Explainer: The agent work area is where PRDs, implementation issue files, and plans live for this repo. These files are private local working documents for agents, not public project artifacts.

Default:

- PRDs: `.ai/prd/`
- Issues: `.ai/issues/<feature-slug>/`
- Plans: `.ai/docs/plans/`
- Required metadata: `status: ready-for-agent` for agent-ready PRDs and issues
- `.gitignore` must include `.ai/`; create `.gitignore` if needed

Ask only whether the user wants to add any extra local subdirectories.

**Section B — Triage status vocabulary.**

> Explainer: Local issue files use a `status` frontmatter field so agents can tell whether work is ready, waiting on information, or not planned.

The canonical local statuses:

- `needs-triage` — maintainer needs to evaluate
- `needs-info` — waiting on reporter
- `ready-for-agent` — fully specified, AFK-ready
- `ready-for-human` — needs human implementation
- `wontfix` — will not be actioned

Default: use these strings exactly. Ask the user if they want to override any.

**Section C — Domain docs.**

> Explainer: Some skills (`improve-codebase-architecture`, `diagnose`, `tdd`) read a `CONTEXT.md` file to learn the project's domain language, and `docs/adr/` for past architectural decisions. They need to know whether the repo has one global context or multiple context files.

Confirm the layout:

- **Single-context** — one `CONTEXT.md` plus `docs/adr/` at the repo root. Most repos are this.
- **Multi-context** — `CONTEXT-MAP.md` at the root pointing to per-context `CONTEXT.md` files.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/local-work.md`, `docs/agents/triage-statuses.md`, `docs/agents/domain.md`

Let them edit before writing.

### 4. Write

**Pick the file to edit:**

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create — don't pick for them.

Never create `AGENTS.md` when `CLAUDE.md` already exists (or vice versa) — always edit the one that's already there.

If an `## Agent skills` block already exists in the chosen file, update its contents in-place rather than appending a duplicate. Don't overwrite user edits to the surrounding sections.

The block:

```markdown
## Agent skills

### Local agent files

PRDs, implementation issues, and plans are private local files under `.ai/`. `.ai/` must be listed in `.gitignore`; create `.gitignore` if needed. See `docs/agents/local-work.md`.

### Triage statuses

Local issue readiness is tracked with `status` frontmatter. See `docs/agents/triage-statuses.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

Then write the three docs files using the seed templates in this skill folder as a starting point:

- [local-work.md](./local-work.md) — local agent work conventions
- [triage-statuses.md](./triage-statuses.md) — status mapping
- [domain.md](./domain.md) — domain doc consumer rules and layout

Always ensure `.ai/` is listed in `.gitignore`. If `.gitignore` exists and does not include `.ai/`, add it. If `.gitignore` does not exist, create it with `.ai/` in it.

### 5. Done

Tell the user the setup is complete and which engineering skills will now read from these files. Mention they can edit `docs/agents/*.md` directly later.
