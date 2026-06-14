#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_SKILLS_DIR="${AGENTS_SKILLS_DIR:-/home/piotr/.agents/skills}"
CODEX_SKILLS_DIR="${CODEX_SKILLS_DIR:-/home/piotr/.codex/skills}"

mkdir -p "$AGENTS_SKILLS_DIR"

for skill_dir in "$ROOT"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill_name="$(basename "$skill_dir")"
  rm -rf "$AGENTS_SKILLS_DIR/$skill_name"
  cp -a "$skill_dir" "$AGENTS_SKILLS_DIR/$skill_name"
done

mkdir -p "$CODEX_SKILLS_DIR"

for skill_name in bsplic-bet-agent-ops thermo-nuclear-code-quality-review; do
  if [ -d "$ROOT/skills/$skill_name" ]; then
    rm -rf "$CODEX_SKILLS_DIR/$skill_name"
    cp -a "$ROOT/skills/$skill_name" "$CODEX_SKILLS_DIR/$skill_name"
  fi
done

echo "Installed skills from $ROOT"
echo "Agents skills: $AGENTS_SKILLS_DIR"
echo "Codex skills: $CODEX_SKILLS_DIR"
