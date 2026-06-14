# Triage Statuses

Local issue and PRD readiness is tracked with a `status` field in markdown frontmatter.

| Canonical role | Local `status` value | Meaning |
| --- | --- | --- |
| `needs-triage` | `needs-triage` | Maintainer needs to evaluate this item |
| `needs-info` | `needs-info` | Waiting on reporter for more information |
| `ready-for-agent` | `ready-for-agent` | Fully specified, ready for an AFK agent |
| `ready-for-human` | `ready-for-human` | Requires human implementation |
| `wontfix` | `wontfix` | Will not be actioned |

When a skill mentions readiness, use the corresponding local `status` value in frontmatter.

Example:

```yaml
---
status: ready-for-agent
title: Add campaign lifecycle states
created: 2026-06-14
---
```
