## Project Specific Rules

- This repository is expected to live at `~/.local/share/agents`.
- This repository is the canonical source for shared agent references, skills, and configuration.
- When refreshing another repository from this baseline, treat `~/.local/share/agents/COMMON.md` as mandatory shared baseline guidance.
- Each project's `AGENTS.md` should direct agents to `~/.local/share/agents/COMMON.md` for shared baseline rules and `~/.local/share/skills/refresh-agents-skill/SKILL.md` for regeneration instructions.
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

- Follow `~/.local/share/skills/coding-standards-skill/SKILL.md` for cross-language coding standards, engineering principles, implementation guidance, and repository hygiene guidance.
- Follow `~/.local/share/skills/ruby-skill/SKILL.md` for baseline Ruby language guidance outside framework-specific specialist skills.
- Follow `~/.local/share/skills/swift-skill/SKILL.md` for baseline Swift language guidance outside the specialist SwiftUI, SwiftData, Swift Testing, and Swift concurrency skills.
- Use `~/.local/share/skills/validation-flow-skill/SKILL.md` when validating code changes.
- Use `~/.local/share/skills/codex-git-skill/SKILL.md` for git operations.
- Use `~/.local/share/skills/codex-github-skill/SKILL.md` for GitHub operations.
- Use `~/.local/share/skills/refresh-agents-skill/SKILL.md` to refresh project `AGENTS.md` files.
- Use `~/.local/share/agents/codex/skills/refresh-public-skills/SKILL.md` when auditing, syncing, linking, or checking published skill repos.

To refresh this file, use the `~/.local/share/skills/refresh-agents-skill/SKILL.md` skill.
