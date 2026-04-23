## Project Specific Rules

- This repository is the canonical home for shared agent references, skills, and configuration.
- This repository is expected to live at `~/.local/share/agents`.
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
- Use portable path references in docs and guidance. Prefer repository-relative paths for files in this repository and `~/...` home-relative paths for shared resources outside it. Avoid machine-specific absolute paths.
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
- Use the `refresh` skill for shared resource maintenance, public skill sync/link/status checks, optional guidance research, and project `AGENTS.md` refreshes.

To refresh this file, use the `refresh` skill.
