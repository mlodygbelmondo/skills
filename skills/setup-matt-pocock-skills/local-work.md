# Local Agent Work

PRDs, implementation issues, plans, and related agent work files for this repo live under `.ai/`.

`.ai/` is private local agent state. It must be listed in `.gitignore` and must stay local.

Before creating or updating any file under `.ai/`, ensure `.ai/` is listed in `.gitignore`. If `.gitignore` does not exist, create it with `.ai/`.

## Conventions

- PRDs live in `.ai/prd/`
- Implementation issues live in `.ai/issues/<feature-slug>/`
- Plans live in `.ai/docs/plans/`
- Agent-ready PRDs and issues include `status: ready-for-agent` in frontmatter
- HITL issue files may use `status: ready-for-human`
- Comments and conversation history can be appended to the bottom of local files under a `## Comments` heading

## When a skill says "save a PRD"

Create a new file under `.ai/prd/`, creating the directory if needed.

## When a skill says "save issues"

Create new files under `.ai/issues/<feature-slug>/`, creating the directory if needed.

## When a skill says "fetch the relevant ticket"

Read the local file path the user provided. If the user provides only a short name, search under `.ai/`.
