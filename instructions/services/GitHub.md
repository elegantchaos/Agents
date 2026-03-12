# GitHub Workflow Guidance

Relevance: include this file when work involves GitHub operations, especially via `gh` CLI (PR creation/editing, issue workflows, CI actions, release flow).

## Why this file exists

This module captures baseline GitHub workflow expectations.

For task-specific GitHub workflows, use the owning shared skills instead of duplicating their command details here:
- use `make-pr` for pull request creation and editing
- use `draft-release` for GitHub draft release preparation
- use `codex-git` for Codex-specific git write/escalation rules that accompany GitHub workflows

## Review and Workflow Hygiene

- Keep PR descriptions factual and scoped to the actual diff.
- Include validation summary and any known gaps.
- Avoid mixing unrelated changes in a single PR when possible.
