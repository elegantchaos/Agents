# Rebuild Process for Project AGENTS Files

This file defines how to regenerate a project's instruction artifacts from shared guidance.

## Goal

Produce a compact, project-targeted `AGENTS.md` for agents, while preserving project-local instructions and providing clear human-readable guideline docs.

The agents file should contain two main sections:

- Project Specific Rules
- Standard Rules

## Required Inputs

- target project repository
- target project's existing `AGENTS.md`
- this repository's `instructions/COMMON.md`, this file, and relevant files under `instructions/` (including subfolders such as `languages/`, `technologies/`, and `services/`)

## Rebuild Workflow

1. Load context

- Read the target project's existing `AGENTS.md`.
- Read shared common files and relevant instruction modules.
- Detect technologies in use from repo evidence (for example: `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, `tsconfig.json`).

2. Preserve Project Specific Rules

- Retain any project-specific policies, constraints, architecture notes, and workflows at the top of rebuilt `AGENTS.md`.
- Remove or rewrite only clearly obsolete or contradictory local instructions.

3. Rewrite Standard Rules

- Replace the rest of the file with compact agent guidance, based on `instructions/COMMON.md`.
- Always include the core guidance from `instructions/COMMON.md` in rebuilt `AGENTS.md` (for example engineering principles, testing/validation expectations, safety, and source-quality rules).
- Add stack-relevant guidance from `instructions/` modules only when those languages/tools/services are used by the project.
- Prefer concrete, checkable instructions over narrative explanation.
- Exclude unrelated language/framework/service modules.
- You may compress guidance for agent ingestion, but must:
  - preserve the intent.
  - preserve principles.
  - rewrites are acceptable only when the underlying meaning remains intact.

4. Add regeneration note

- At the bottom of `AGENTS.md`, add a short note that this regeneration process should be repeated regularly.
- Include a simple pointer to the canonical refresh workflow (`codex/skills/agents-refresh/WORKFLOW.md`) and baseline guidance (`instructions/COMMON.md`) so repeating the process is easy.

5. Copy relevant guideline files

- Copy relevant files from `instructions/` into `Extras/Documentation/Guidelines/`.
- Include core cross-cutting modules by default (`Principles.md`, `Testing.md`, `Trusted Sources.md`, `Good Code.md`), then add only relevant language/technology/service modules.
- Overwrite only managed copied files.
- Avoid touching project-authored docs outside the managed set.
- In each section of the new AGENTS.md, add links to the local copies of any relevant guidance files.

6. Optionally regenerate a human companion file

- Create/update a project notes markdown at `Extras/Documentation/Guidelines/Agent-Guidance-Notes.md` with:
  - regenerated files
  - included and excluded modules
  - detected stack assumptions
  - unresolved local-vs-shared instruction conflicts

## Selection Rules

- Treat `instructions/COMMON.md` as mandatory baseline guidance for every project refresh.
- Treat `instructions/` files as detailed, context-specific guidance (language/tool specific).
- Include non-specific principles in the final `AGENTS.md` even when compacting text.
- Prefer root-level instruction modules (`Principles.md`, `Testing.md`, `Trusted Sources.md`, `Good Code.md`) as the default human-readable copied set.
- Include language modules only when that language is present.
- Include technology/service modules only when actively used.
- If uncertain, preserve shared principles in `AGENTS.md` and move optional detail to copied human docs.

## Reporting Expectations

When finishing a rebuild, clearly state:

- what changed
- which modules were included
- what was copied into project guideline docs
- any unresolved instruction conflicts
