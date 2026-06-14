---
name: orchestrator
description: Use only when the user explicitly mentions $orchestrator or asks to use the orchestrator skill for a pasted implementation plan with ordered tasks.
---

# Orchestrator

Use this skill only when the user explicitly mentions `$orchestrator` or directly asks to use the orchestrator skill. Do not invoke this skill implicitly for ordinary implementation plans, code reviews, or subagent work.

Use it when the user provides a ready plan plus ready tasks and wants Codex to orchestrate implementation through subagents.

The intended controller setup is `gpt-5.5` with `xhigh` reasoning effort. A skill cannot change the current orchestrator model by itself, so treat that as a session/model setting the user selects before invoking the skill.

## Subagent Profiles

- Worker profile: read `references/worker-subagent.md`.
- Reviewer profile: read `references/reviewer-subagent.md`.

## Workflow

1. Parse the pasted plan into an ordered task list. Preserve the user's wording for acceptance criteria and constraints.
2. Create a visible checklist for all tasks when planning tools are available.
3. Inspect the repository just enough to identify project commands, formatter, test commands, and relevant ownership boundaries.
4. Start one implementation worker at a time. Prefer a single long-lived worker if the runtime allows `send_input` after each completed task; otherwise spawn a fresh worker with the same profile for each task.
5. For each task, give the worker only:
   - the full plan summary,
   - the current task text,
   - acceptance criteria,
   - relevant files or commands discovered by the orchestrator,
   - the instruction to stop after this task.
6. Wait for that task to finish before starting the next task. Do not dispatch implementation tasks in parallel.
7. After every worker result, inspect the changed files or returned summary, run the relevant formatter and tests locally when feasible, and decide whether a small follow-up worker prompt is needed.
8. After all tasks are complete, gather the final review packet:
   - original plan and task list,
   - changed files,
   - git diff or patch,
   - commands run and their results,
   - known caveats or skipped checks.
9. Spawn the reviewer with the reviewer profile and wait for a standalone Codex-style review.
10. If the reviewer finds blocking issues, convert those findings into new ordered tasks and run the worker loop again. Re-run the reviewer after fixes. If no blocking issues remain, finish with the implemented changes and verification summary.

## Spawn Settings

Use these exact settings unless the user explicitly asks for a different model or effort:

```text
Worker:
agent_type: worker
model: gpt-5.5
reasoning_effort: medium
fork_context: false by default; true only when prior conversation context is essential

Reviewer:
agent_type: explorer
model: gpt-5.5
reasoning_effort: xhigh
fork_context: true
```

Use `xhigh` for the reviewer's "very high" thinking effort.

## Worker Dispatch Template

Load `references/worker-subagent.md`, then fill in:

- `PLAN`
- `COMPLETED TASKS`
- `CURRENT TASK`
- `ACCEPTANCE CRITERIA`
- `FILES / MODULES OWNED`
- `COMMANDS TO RUN`
- `STOP CONDITION`

The worker must edit only its owned area, run the relevant formatter and checks when possible, and report changed paths.

## Reviewer Dispatch Template

Load `references/reviewer-subagent.md`, then fill in:

- `ORIGINAL PLAN`
- `TASKS COMPLETED`
- `CHANGED FILES`
- `DIFF / PATCH`
- `VERIFICATION`
- `KNOWN CAVEATS`

The reviewer is read-only unless the user explicitly asks for fixes. Its output should be findings first, ordered by severity, with file and line references where possible.

## Guardrails

- Do not begin without an ordered task list. If the pasted plan is ambiguous, extract the most likely task list and ask only for missing information that would make implementation risky.
- Do not let the worker choose the next task. The orchestrator owns ordering.
- Do not let implementation workers run in parallel.
- Do not skip the final reviewer.
- Do not mark the task complete while the reviewer has unresolved blocking findings.
- Preserve unrelated user changes in the worktree.
- For coding tasks, run the repository's formatter before final completion; prefer the documented formatter, and use Prettier when relevant.
