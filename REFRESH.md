# Rebuild Process for Project AGENTS Files

This file defines how to regenerate a project's instruction artifacts from shared guidance.

## Goal

Produce a compact, project-targeted `AGENTS.md` for agents, while preserving project-local instructions and providing clear human-readable guideline docs.

## Required Inputs

- target project repository
- target project's existing `AGENTS.md`
- this repository's `COMMON.md`, `REFRESH.md`, and relevant `instructions/*.md`

## Rebuild Workflow

1. Load context
- Read the target project's existing `AGENTS.md`.
- Read shared common files and relevant instruction modules.
- Detect technologies in use from repo evidence (for example: `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, `tsconfig.json`).

2. Preserve project-local instructions
- Keep project-specific policies, constraints, architecture notes, and workflows at the top of rebuilt `AGENTS.md`.
- Remove or rewrite only clearly obsolete or contradictory local instructions.

3. Build compact agent guidance
- Always include the core non-specific shared guidance from `COMMON.md` in rebuilt `AGENTS.md` (for example engineering principles, testing/validation expectations, safety, and source-quality rules).
- Add stack-relevant guidance from `instructions/*.md` only when those languages/tools are used by the project.
- Prefer concrete, checkable instructions over narrative explanation.
- Exclude unrelated language/framework/service modules.
- You may rewrite and compress guidance for agent ingestion, but do not lose the intent or essential principles from `COMMON.md`.
- Shared principles from `COMMON.md` must be preserved; rewrites are acceptable only when the underlying meaning remains intact.

4. Add regeneration note
- At the bottom of `AGENTS.md`, add a short note that this regeneration process should be repeated regularly.
- Include a simple pointer to this file set so repeating the process is easy.

5. Copy human-readable guideline files
- Copy relevant files from `instructions/` into project docs (for example `Extras/Documentation/Guidelines/`).
- Overwrite only managed copied files.
- Avoid touching project-authored docs outside the managed set.

6. Optionally regenerate a human companion file
- Create/update a project notes markdown (for example `Extras/Documentation/Guidelines/Agent-Guidance-Notes.md`) with:
  - regenerated files
  - included and excluded modules
  - detected stack assumptions
  - unresolved local-vs-shared instruction conflicts

## Selection Rules

- Treat `COMMON.md` as mandatory baseline guidance for every project refresh.
- Treat `instructions/` files as detailed, context-specific guidance (language/tool specific).
- Include non-specific principles in the final `AGENTS.md` even when compacting text.
- Include language modules only when that language is present.
- Include technology/service modules only when actively used.
- If uncertain, preserve shared principles in `AGENTS.md` and move optional detail to copied human docs.

## Reporting Expectations

When finishing a rebuild, clearly state:
- what changed
- which modules were included
- what was copied into project guideline docs
- any unresolved instruction conflicts
