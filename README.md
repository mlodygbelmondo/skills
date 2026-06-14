# Skills

Personal Codex/agent skills for Piotr Kaczorowski (`mlodygbelmondo`).

This repository contains local, customized, or user-specific skills that should be easy to reinstall and keep under version control.

## Contents

### Personal workflow skills

- `finish-branch-and-ship`
- `truth-review`
- `prd-implementation-auditor`
- `subagent-review-runner`

### Project-specific skills

- `bsplic-bet-agent-ops`
- `policzona-szama-tag-release`
- `new-branch`

### Local orchestration and review skills

- `orchestrator`
- `thermo-nuclear-code-quality-review`
- `supabase-account-management`

### Customized Matt Pocock-style workflow skills

- `setup-matt-pocock-skills`
- `to-prd`
- `to-issues`
- `improve-codebase-architecture`
- `teach`

The local `to-prd`, `to-issues`, and `setup-matt-pocock-skills` workflows are intentionally local-first: PRDs, implementation issues, and plans live under `.ai/`, and `.ai/` must be listed in `.gitignore`.

## Install

From this repository:

```bash
./install.sh
```

By default, this installs every directory under `skills/` into:

```text
/home/piotr/.agents/skills/
```

It also installs `bsplic-bet-agent-ops` and `thermo-nuclear-code-quality-review` into:

```text
/home/piotr/.codex/skills/
```

because those copies are used by the current Codex setup.

## Safety

Do not commit secrets. Skills may reference local secret file paths, but they must not contain actual tokens, passwords, Supabase service-role keys, or raw environment values.
