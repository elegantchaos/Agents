# <Project Name> — Agent Guide

This project `AGENTS.md` is rebuilt from the canonical agents repository baseline.

## Project Specific Rules

Keep this section project-authored and at the top when regenerating.

- Product/domain summary:
- Architecture constraints and invariants:
- Key docs (absolute or repo-relative paths):
- Key scripts/commands:
- Validation commands:
- Allowed dependency policy:
- Secret/config handling:
- Explicit do-not-touch areas:

## Standard Rules

Rebuild this section from:
- `instructions/COMMON.md`
- `codex/skills/refresh-agents/SKILL.md`
- stack-relevant modules under `instructions/`

Apply these baseline expectations:
- Make minimal, focused changes that solve the requested problem.
- Preserve existing architecture/style unless change is required.
- Add or update tests for behavior changes where feasible.
- Run relevant validation and report gaps/risks.
- Avoid destructive actions without explicit approval.
- Never expose or commit credentials/secrets.

Prefer using applicable shared skills in `codex/skills/` for task-specific workflows instead of repeating skill internals in this file.
When `Extras/Documentation/Guidelines/` contains copied guidance files, read the relevant files there to recover full required guidance for the current task.

## Managed Guidance Modules

Core modules to copy into project docs by default:
- `instructions/Principles.md`
- `instructions/Testing.md`
- `instructions/Trusted Sources.md`
- `instructions/Good Code.md`

Add only modules relevant to the detected stack:
- `instructions/languages/Swift.md`
- `instructions/languages/Python.md`
- `instructions/languages/JavaScript.md`
- `instructions/technologies/SwiftUI.md`
- `instructions/services/GitHub.md`

These copied guidance files are agent-first references and may also be useful for humans.

## Regeneration Note

To refresh this file, use the `refresh-agents` skill.
