---
name: creative-frontend-builder
description: "Build visually exceptional production-quality frontend applications from broad creative prompts. Use when the user asks for a creative frontend build, a polished app/site/tool, an OpenCode frontend task, React/Vite/TypeScript app creation, product-design-led implementation, DESIGN_BRIEF.md creation, or requests like build the actual app, make it visually exceptional, avoid generic SaaS aesthetics, do not ask questions, or turn this frontend build prompt into reusable behavior."
---

# Creative Frontend Builder

Use this skill to turn an open-ended frontend request into a complete, polished application.

## Core Rule

Make product and design decisions yourself. Do not ask clarifying product questions when a reasonable creative choice can be made. Ask the user only when you are blocked by missing credentials, destructive file operations, inaccessible required assets, or uncertainty that could cause data loss or expose secrets.

## Workflow

1. Inspect the repository first.
   - Read project instructions such as `AGENTS.md`, `CLAUDE.md`, `README.md`, package files, and existing app structure.
   - Identify the stack, package manager, scripts, design system, routing style, and whether the repository is empty.
   - If the repo is empty, create a modern React + TypeScript frontend, preferring Vite unless the repository clearly points elsewhere.
   - Preserve unrelated user changes and follow existing conventions when a project already exists.

2. Create `DESIGN_BRIEF.md` before implementation.
   - Include product name, one-sentence concept, target audience, visual direction, typography approach, color/material system, layout principles, interaction/motion principles, and what makes the design non-generic.
   - Keep it concise but specific enough to guide future iterations.
   - Treat the brief as a contract for the build, not a generic mood board.

3. Define the product experience.
   - Invent or refine the product concept without waiting for approval.
   - Build the actual usable first screen, not only a landing hero.
   - Use realistic copy and realistic mock data.
   - Include complete flows, controls, empty/loading/error states, and microcopy that a real user would expect.
   - Avoid lorem ipsum, decorative-only sections, generic SaaS templates, and boring card grids.

4. Implement with a production frontend bar.
   - Prefer clean React + TypeScript and componentized code.
   - Keep dependencies reasonable and add a library only when it clearly improves the result.
   - Use semantic HTML where appropriate.
   - Create strong visual hierarchy, deliberate typography, excellent spacing, accessible contrast, responsive desktop/tablet/mobile layouts, and polished interactive states.
   - Use visual assets for websites, apps, and games when they materially improve the experience.
   - Do not stop after the hero section; complete the application surface.

5. Design with intention.
   - Choose a memorable visual direction that fits the product domain.
   - Avoid default-looking templates, one-note palettes, excessive rounded card stacks, generic gradients, and in-app explanatory text about the UI itself.
   - Keep layout rhythm stable with explicit responsive constraints for repeated controls, boards, counters, tiles, and panels.
   - Make text fit its containers across viewport sizes.
   - Use motion sparingly for feedback, continuity, and state changes.

6. Validate before finishing.
   - Run install, build, lint, typecheck, and tests where available and relevant.
   - If a command is missing, say so and use the closest available verification.
   - Fix errors encountered during validation.
   - Start a local dev server when useful for browser verification, and provide the URL.
   - Check that there are no obvious console errors or broken mobile layouts when browser testing is feasible.

## Final Response

Summarize briefly:

- What was built
- Product concept
- Main files changed
- How to run locally
- Validation and build results
- Any compromises or known issues
