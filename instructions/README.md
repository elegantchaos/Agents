# Shared Instruction Modules

These files are shared guidance modules used when rebuilding project `AGENTS.md` files from the common guidance set (`~/.local/share/agents/instructions/COMMON.md`, `~/.local/share/skills/refresh-agents-skill/SKILL.md`).

They are written to serve both:
- agents selecting and applying task-relevant rules
- humans maintaining the shared baseline

## How to use this folder

- Keep each module focused on a clear domain (principles, validation, sources, or language baseline).
- Start each module with relevance criteria so agents can decide if it applies.
- Write guidance in clear, direct language that remains useful when referenced directly from project docs.
- Prefer routing to shared skills for specialized or host-specific workflows instead of copying detailed skill procedures into these modules.

## Intended reference workflow

When rebuilding project instructions, reference only the relevant shared modules under `~/.local/share/agents/instructions/`.

Suggested shared set by default:
- `Principles.md`
- `Validation.md`
- `Trusted Sources.md`
- `Good Code.md`
- `Portability.md`

Add language modules only when the project uses them.
