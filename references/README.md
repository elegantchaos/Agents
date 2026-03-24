# Shared Reference Modules

These files are shared guidance modules used when rebuilding project `AGENTS.md` files from the common guidance set (`~/.local/share/agents/references/COMMON.md`, `~/.local/share/skills/refresh-agents-skill/SKILL.md`).

They are written to serve both:
- agents selecting and applying task-relevant rules
- humans maintaining the shared baseline

## How to use this folder

- Keep each module focused on a clear domain such as validation, portability, or other durable baseline policy not owned by a dedicated skill.
- Start each module with relevance criteria so agents can decide if it applies.
- Write guidance in clear, direct language that remains useful when referenced directly from project docs.
- Prefer routing to shared skills for specialized or host-specific workflows instead of copying detailed skill procedures into these modules.

## Intended reference workflow

When rebuilding project instructions, reference only the relevant shared modules under `~/.local/share/agents/references/`.

Suggested shared set by default:
- `Validation.md`
- `Portability.md`

General coding standards and trusted-source guidance now live in `~/.local/share/skills/coding-standards-skill/SKILL.md`.
Baseline Ruby guidance now lives in `~/.local/share/skills/ruby-skill/SKILL.md`.
Baseline Swift language guidance now lives in `~/.local/share/skills/swift-skill/SKILL.md`.
Baseline JavaScript and TypeScript guidance now lives in `~/.local/share/skills/javascript-skill/SKILL.md`.
Baseline Python guidance now lives in `~/.local/share/skills/python-skill/SKILL.md`.

Add remaining language modules only when the project uses them and no dedicated skill owns that guidance.
