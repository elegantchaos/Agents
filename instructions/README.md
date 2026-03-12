# Shared Instruction Modules

These files are shared guidance modules used when rebuilding project `AGENTS.md` files from the common guidance set (`instructions/COMMON.md`, `~/.local/share/skills/refresh-agents-skill/SKILL.md`).

They are written to serve both:
- agents selecting and applying task-relevant rules
- humans reading copied guideline files inside projects

## How to use this folder

- Keep each module focused on a clear domain (principles, testing, sources, language, technology, or service).
- Start each module with relevance criteria so agents can decide if it applies.
- Write guidance in clear, direct language that remains useful after copying into project docs.
- Prefer routing to shared skills for specialized or host-specific workflows instead of copying detailed skill procedures into these modules.

## Intended project copy workflow

When rebuilding project instructions, copy only relevant modules into the project's guideline directory (for example `Extras/Documentation/Guidelines/`).

Suggested copied set by default:
- `Principles.md`
- `Validation.md`
- `Trusted Sources.md`

Add language/service modules only when the project uses them.
