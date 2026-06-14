---
name: subagent-review-runner
description: "Run a delegated review or implementation audit through an available subagent, then validate and act on the result. Use when the user asks to run a subagent, run a review with a specific skill, use gpt-5.5/xhigh, consolidate subagent findings, fix findings from a subagent, or orchestrate review workers from a plan."
---

# Subagent Review Runner

Use this skill when the user wants a separate reviewer or worker pass, especially for harsh code reviews, PRD verification, architecture review, or multi-step plan execution.

## Core Rule

If you are not sure which subagent tool, model, reasoning effort, skill, branch, worktree, or review scope the user wants, ask before launching work. Subagents can be expensive and can produce noisy findings, so do not guess on high-impact parameters.

## Workflow

1. Clarify scope.
   - Identify the target repo, branch/worktree, diff range, PRD/plan, and requested skill.
   - If the user gave a local skill path, read that skill first.
   - If the requested subagent tooling is not already visible, search for the relevant multi-agent tools before falling back to a local review.

2. Prepare the reviewer brief.
   - Include the exact task, repo path, branch, files or diff range, and quality bar.
   - Tell the subagent to provide evidence with file/line references.
   - Tell the subagent to separate confirmed issues from uncertainty.
   - Tell the subagent not to edit files unless the user explicitly requested implementation work.

3. Run the subagent.
   - Prefer the model and effort requested by the user.
   - If the user asks for a strict review and does not specify settings, prefer the strongest locally available reviewer configuration.
   - If no subagent tool is available, perform the review directly and say that delegation was unavailable.

4. Validate the output.
   - Do not blindly trust the subagent.
   - Re-check every high-severity finding against code.
   - Dismiss false positives, speculative issues, and overengineering.
   - Ask the user when a finding depends on product intent.

5. Act only on confirmed scope.
   - If the user asked to fix findings, fix only confirmed findings.
   - If a fix would expand scope, change behavior, or conflict with the PRD, ask first.
   - Run relevant verification after fixes.

## Output Shape

Report:

- Subagent used, model/effort if known, and scope
- Confirmed findings
- Dismissed or uncertain findings
- Fixes made, if any
- Verification run
