## Project Specific Rules

- This repository is expected to live at `~/.local/share/agents`.
- This repository is the canonical source for shared agent references, skills, and configuration.
- When refreshing another repository from this baseline, treat `~/.local/share/agents/COMMON.md` as mandatory shared baseline guidance.
- Each project's `AGENTS.md` should direct agents to `~/.local/share/agents/COMMON.md` for shared baseline rules and the `refresh-agents` skill for regeneration instructions.
- Because this repository owns the shared baseline, agents working here should edit shared guidance at the source files and skill repos rather than creating duplicate local copies.

## Standard Rules

- Read `~/.local/share/agents/COMMON.md` first.
- Keep generated `Standard Rules` sections limited to durable repo-wide policy. Put skill-owned procedural or domain guidance in `Skills`.
- Always write good code.
- Apply DRY and single-source-of-truth as required principles. Prefer KISS, YAGNI, make-illegal-states-unrepresentable, dependency injection, composition over inheritance, command-query separation, least knowledge, structured concurrency, design by contract, and idempotency.
- Understand request boundaries, inspect relevant code and docs before editing, apply the smallest coherent change set, run relevant validation, and report residual risks.
- Use red/green TDD for non-UI code.
- Create previews for UI code.
- Follow the validation workflow and report every check you ran, every check you skipped, and the reason for each skipped check.
- Use trusted primary sources for technical decisions.
- Keep shared references portable and avoid machine-specific absolute paths. Prefer repository-relative paths unless local guidance explicitly requires a canonical shared path.
- Never expose or commit credentials or secrets.
- Do not perform destructive actions without explicit approval.
- If unexpected workspace changes appear, pause and confirm direction before proceeding.
- Avoid unrelated refactors during focused tasks.

## Skills

- Follow the `coding-standards` skill for cross-language coding standards, engineering principles, implementation guidance, and repository hygiene guidance.
- Follow the `ruby` skill for baseline Ruby language guidance outside framework-specific specialist skills.
- Follow the `swift` skill for baseline Swift language guidance.
- Use the `validation-flow` skill when validating code changes.
- Use the `codex-git` skill for git operations.
- Use the `codex-github` skill for GitHub operations.
- Use the `refresh-agents` skill to refresh project `AGENTS.md` files.
- Use the `refresh-public-skills` skill when auditing, syncing, linking, or checking published skill repos.

To refresh this file, use the `refresh-agents` skill.
