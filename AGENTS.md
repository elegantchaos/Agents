## Project Specific Rules

- This repository is expected to live at `~/.local/share/agents`.
- This repository is the canonical source for shared agent instructions, skills, and configuration.
- When refreshing another repository from this baseline, treat `~/.local/share/agents/instructions/COMMON.md` as mandatory and select only the relevant modules under `~/.local/share/agents/instructions/`.
- Each project's `AGENTS.md` should direct agents to `~/.local/share/agents/instructions/COMMON.md` for shared baseline rules and `~/.local/share/skills/refresh-agents-skill/SKILL.md` for regeneration instructions.
- Because this repository owns the shared baseline, agents working here should link directly to files under `~/.local/share/agents/instructions/`.
- For git operations in Codex.app, use `~/.local/share/skills/codex-git-skill/SKILL.md`.

## Standard Rules

Read `~/.local/share/agents/instructions/COMMON.md` first, then load only the modules relevant to the task. For this repository, the default shared references are `~/.local/share/agents/instructions/Principles.md`, `~/.local/share/agents/instructions/Validation.md`, `~/.local/share/agents/instructions/Good Code.md`, `~/.local/share/agents/instructions/Trusted Sources.md`, `~/.local/share/agents/instructions/Portability.md`, and `~/.local/share/agents/instructions/languages/Swift.md`.

- Write good code as defined in `~/.local/share/agents/instructions/Good Code.md`.
- Apply shared engineering principles from `~/.local/share/agents/instructions/Principles.md`: DRY, Single Source of Truth, KISS, YAGNI, Make Illegal States Unrepresentable, Dependency Injection, Composition Over Inheritance, Command-Query Separation, Law of Demeter, Structured Concurrency, Design by Contract, and Idempotency.
- Prefer minimal, focused changes that solve the requested problem and fix root causes instead of layering workarounds.
- Avoid mixed architecture or mixed style within the same code path. If a modernization is warranted, migrate coherently and update dependents in the same change.
- Do not add shims, wrappers, adapters, aliases, or backward-compatibility layers unless the user explicitly asks for compatibility support.
- Keep interfaces explicit, small, and unsurprising. Avoid hidden coupling, surprising side effects, unnecessary dependencies, and committed secrets.
- Prefer Swift for repository-maintained automation and helper scripts.
- Use red/green TDD for non-UI code.
- Create previews for UI code.
- Follow the validation workflow in `~/.local/share/agents/instructions/Validation.md` and report every check you ran, every check you skipped, and the reason for each skipped check.
- Keep documentation factual and aligned with current behavior. Update local docs when workflows, commands, or architecture change.
- Add concise documentation comments for types, methods, functions, and members when you modify them. Comments should explain intent and constraints, not restate names.
- Use trusted primary sources for technical decisions. Follow `~/.local/share/agents/instructions/Trusted Sources.md`; prefer official vendor docs, language references, specifications, and primary proposals over secondary summaries.
- Keep shared references portable. Follow `~/.local/share/agents/instructions/Portability.md` and use `~/...` paths for canonical shared resources.
- For GitHub workflows, use `~/.local/share/skills/codex-github-skill/SKILL.md`.
- Do not perform destructive actions without explicit approval.
- If unexpected workspace changes appear, pause and confirm direction before proceeding.
- Avoid unrelated refactors during focused tasks.

To refresh this file, use the `~/.local/share/skills/refresh-agents-skill/SKILL.md` skill.
