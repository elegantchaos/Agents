---
name: refresh-agents
description: Regenerate a project AGENTS.md and related guideline docs from the shared agents repository baseline. Use when updating stale project agent instructions, syncing standards into a repo, or running the refresh-agents skill.
---

# Agents Refresh

Rebuild project instruction artifacts from shared guidance while preserving project-specific rules.

## Shared Location

Shared baseline files are in `~/.local/share/agents`.

When refreshing another repository, resolve shared inputs from this location:
- `~/.local/share/agents/instructions/COMMON.md`
- `~/.local/share/agents/instructions/`

## Goal

Produce a compact, project-targeted `AGENTS.md` for agents, while preserving project-local instructions and providing copied guidance docs that agents can read for full detail.

The rebuilt agents file should contain two main sections:
- `Project Specific Rules`
- `Standard Rules`

## Required Inputs

- target project repository
- target project's existing `AGENTS.md`
- shared `instructions/COMMON.md` and relevant files under `instructions/` (including subfolders such as `languages/`, `technologies/`, and `services/`)

## Rebuild Workflow

1. Load context
- Read the target project's existing `AGENTS.md`.
- Read shared common files and relevant instruction modules from `~/.local/share/agents`.
- Detect technologies in use from repo evidence (for example: `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, `tsconfig.json`).

2. Preserve Project Specific Rules
- Retain project-specific policies, constraints, architecture notes, and workflows at the top of rebuilt `AGENTS.md`.
- Remove or rewrite only clearly obsolete or contradictory local instructions.

3. Rewrite Standard Rules
- Replace the rest of the file with compact agent guidance, based on `instructions/COMMON.md`.
- Always include core guidance from `instructions/COMMON.md` in rebuilt `AGENTS.md` (for example engineering principles, testing/validation expectations, safety, and source-quality rules).
- Add stack-relevant guidance from `instructions/` modules only when those languages/tools/services are used by the project.
- Prefer concrete, checkable instructions over narrative explanation.
- Ensure compact instructions preserve enough context for an agent to locate and load full detail from referenced local guidance files.
- When copied guidance files exist in the target repo, explicitly direct agents to read relevant files under `Extras/Documentation/Guidelines/`.
- Exclude unrelated language/framework/service modules.
- You may compress guidance for agent ingestion, but must preserve intent and principles.

4. Add regeneration note
- At the bottom of `AGENTS.md`, add this exact note: `To refresh this file, use the refresh-agents skill.`

5. Copy relevant guideline files
- Copy relevant files from `instructions/` into `Extras/Documentation/Guidelines/`.
- Include core cross-cutting modules by default (`Principles.md`, `Testing.md`, `Trusted Sources.md`, `Good Code.md`), then add only relevant language/technology/service modules.
- Overwrite only managed copied files.
- Avoid touching project-authored docs outside the managed set.
- In each section of the new `AGENTS.md`, add links to local copies of relevant guidance files.
- Treat copied files as agent-first references that capture full required guidance; they are not just human companion docs.

6. Optionally regenerate a companion notes file
- Create or update `Extras/Documentation/Guidelines/Agent-Guidance-Notes.md` with:
- regenerated files
- included and excluded modules
- detected stack assumptions
- unresolved local-vs-shared instruction conflicts

## Selection Rules

- Treat `instructions/COMMON.md` as mandatory baseline guidance for every refresh.
- Treat `instructions/` files as detailed, context-specific guidance.
- Include non-specific principles in final `AGENTS.md` even when compacting text.
- Prefer root-level instruction modules (`Principles.md`, `Testing.md`, `Trusted Sources.md`, `Good Code.md`) as the default copied set for agent consumption.
- Include language modules only when that language is present.
- Include technology/service modules only when actively used.
- If uncertain, preserve shared principles in `AGENTS.md` and move optional detail to copied agent-readable docs.

## Output Checklist

In the final response, always include:

- Files changed
- Modules included and excluded
- Evidence used for stack detection
- What was copied into guideline docs
- Any unresolved local-vs-shared instruction conflicts
