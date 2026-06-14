---
name: finish-branch-and-ship
description: "Finish a local coding branch safely: inspect branch state, sync against the intended base, run the repo's relevant verification, perform mandatory format checks for commit/push/merge readiness requests, create a conventional commit, and push. Use when the user asks to finish work, commit, push, ship, prepare for merge, check readiness, zcommituj, zpushuj, czy gotowe, ready to merge, or similar."
---

# Finish Branch And Ship

Use this skill when the user wants a branch brought to a clean, shareable state.

## Core Rule

If you are not sure about the target branch, commit scope, verification command, merge readiness bar, or whether an uncommitted change belongs to the user, stop and ask the user. Do not guess when the wrong guess could lose work or publish the wrong change.

## Workflow

1. Inspect repository state.
   - Read `AGENTS.md` / `CLAUDE.md` if present.
   - Run `git status --short`, `git branch --show-current`, and inspect remotes.
   - Identify dirty files and distinguish task-related changes from unrelated user changes.
   - Never revert unrelated or user-owned changes.

2. Confirm the intended base when needed.
   - If the user mentions `main`, `origin/main`, merge readiness, or production, fetch the remote and compare against the intended base.
   - If the base branch is ambiguous, ask the user.
   - Do not run destructive commands such as `git reset --hard` or `git checkout -- <path>` unless the user explicitly requested that exact operation.

3. Review the diff before committing.
   - Inspect changed files with `git diff` and staged diff if anything is staged.
   - Verify the branch contains only changes that should be committed.
   - If unrelated changes are present, leave them alone and either commit only the intended paths or ask the user if the scope is unclear.

4. Run verification scaled to the change.
   - Prefer documented repo commands from `package.json`, README, AGENTS, CI config, or existing scripts.
   - For readiness, merge, PR, commit, or push requests, run the repo's documented format check when available.
   - Run typecheck, lint, tests, build, or e2e only when relevant to the touched surface or requested readiness bar.
   - If a command is missing, too broad, too expensive, or blocked by environment, say so clearly and use the closest safe verification.

5. Commit.
   - Use existing commit message conventions if visible in recent history.
   - Stage only the intended files.
   - If the user asks for "all changes" and unrelated changes are present, confirm before including them unless they clearly belong to the same task.

6. Push.
   - Push the current branch to its upstream.
   - If no upstream exists, set upstream to the current branch name unless the user specified otherwise.
   - Report the branch, commit hash, verification commands, and anything skipped or blocked.

## Output

Keep the final report concise:

- Branch and commit hash
- Verification run and result
- Push destination
- Remaining risks or skipped checks
