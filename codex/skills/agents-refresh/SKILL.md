---
name: agents-refresh
description: Regenerate a project AGENTS.md and related guideline docs from the shared agents repository baseline. Use when updating stale project agent instructions, syncing standards into a repo, or running the agents-refresh workflow.
---

# Agents Refresh

Rebuild project instruction artifacts from shared guidance while preserving project-specific rules.

## Workflow

1. Load required inputs:
- target repository
- target `AGENTS.md`
- shared `instructions/COMMON.md`
- shared `codex/skills/agents-refresh/WORKFLOW.md`
- relevant files under `instructions/`

2. Detect stack evidence from the target repo (for example Swift, Python, JavaScript, SwiftUI, GitHub CLI workflows).

3. Preserve project-specific rules at the top of `AGENTS.md`.
- Keep local architecture/process constraints.
- Remove only clearly obsolete or contradictory local guidance.

4. Rewrite standard rules with compact, checkable guidance.
- Always include baseline intent from `instructions/COMMON.md`.
- Add only stack-relevant modules from `instructions/`.
- Preserve meaning when compressing content.

5. Add a regeneration note at the bottom of `AGENTS.md`.
- Point to shared files used for refresh (`instructions/COMMON.md`, `codex/skills/agents-refresh/WORKFLOW.md`).

6. Copy relevant guideline files into project docs.
- Use `Extras/Documentation/Guidelines/` as the required destination for copied guidance modules.
- Always include: `Principles.md`, `Testing.md`, `Trusted Sources.md`, `Good Code.md`.
- Add only relevant language/technology/service modules.
- Overwrite only managed copied files.
- Avoid touching project-authored docs outside the managed set.

7. Optionally regenerate a companion notes file (for example `Agent-Guidance-Notes.md`) summarizing modules selected, assumptions, and conflicts.

## Selection Rules

- Treat `instructions/COMMON.md` as mandatory.
- Prefer root-level modules as the default human-readable copied set.
- Include language modules only when that language is present.
- Include technology/service modules only when actively used.
- If uncertain, keep shared principles in `AGENTS.md` and move optional detail to copied docs.

## Output Checklist

In the final response, always include:

- Files changed
- Modules included and excluded
- Evidence used for stack detection
- What was copied into guideline docs
- Any unresolved local-vs-shared instruction conflicts
