---
name: policzona-szama-tag-release
description: Use when the user asks to prepare, tag, or publish a Policzona Szama production release tag. This workflow requires a release number and creates or pushes a git tag named release slash release-number from the production branch.
---

# Policzona Szama Tag Release

Use this skill only for creating a Policzona Szama production release tag. If the user did not provide the release number, ask for it before running any git commands. Checkout `production`, run `git pull origin production`, create `git tag release/<release-number>`, then push it with `git push origin release/<release-number>`. After the tag is pushed, ask which branch to return to, offering `main` as the default. Checkout the chosen return branch only after the user answers.
