---
name: new-branch
description: Create a new Git branch for the Policzona Szama project from a ticket number and request type. Use when the user asks to make, create, or switch to a new branch and provides a PSM ticket number plus a type such as feature, bug, fixing, or improvement.
---

# New Branch

Create branches for the Policzona Szama repository using the local project convention.

## When to use

Use this skill when all are true:

- The current workspace is `/home/piotr/policzona-szama/main` or another path inside the Policzona Szama repo.
- The user asks to create a new branch.
- The user gives a ticket number, either as a plain number (`215`) or a PSM ticket (`PSM215`, `PSM-215`).
- The user gives or implies one of these request types: `feature`, `bug`, `fixing`, `improvement`.

## Branch format

Normalize branches to:

```text
<prefix>/PSM-<ticket-number>-<description-slug>
```

Type prefix mapping:

```text
feature     -> feature
bug         -> bugfix
fixing      -> bugfix
fix         -> bugfix
bugfix      -> bugfix
improvement -> improvement
```

Ticket normalization:

```text
215     -> PSM-215
PSM215  -> PSM-215
PSM-215 -> PSM-215
psm 215 -> PSM-215
```

Description slug:

- Use the remaining task description when the user provides one, e.g. `greyout past days` -> `greyout-past-days`.
- Lowercase it.
- Transliterate Polish characters if needed.
- Replace whitespace and punctuation with `-`.
- Remove duplicate and trailing `-`.
- Keep it short and descriptive.
- If no description is provided, create `<prefix>/PSM-<ticket-number>` rather than inventing a description.

## Workflow

1. Confirm the repository is Policzona Szama by checking the current path or repository root.
2. Parse and normalize the type, ticket number, and optional description.
3. Build the branch name using the format above.
4. Run:

```bash
git checkout -b "<branch-name>"
```

5. If the branch already exists, switch to it with:

```bash
git checkout "<branch-name>"
```

6. In the final answer, report only the created or selected branch name unless the user asked for more detail.

## Examples

User: `Zrób branch PSM215 greyout past days, feature`

Branch:

```text
feature/PSM-215-greyout-past-days
```

User: `Nowy branch bug PSM 231 user seeing draft recipes`

Branch:

```text
bugfix/PSM-231-user-seeing-draft-recipes
```

User: `Branch improvement 296 visual changes to day optimizer`

Branch:

```text
improvement/PSM-296-visual-changes-to-day-optimizer
```
