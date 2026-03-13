# Portability and Shared Paths

Relevance: include this file for repositories that consume the shared agents baseline or publish shared skills, rules, or configuration.

## Purpose

Use this file to keep shared guidance portable across machines and repositories.

## Path Rules

- Use `~/...` home-relative paths when referring to canonical shared resources under the shared agents repository or shared skills home.
- Use repository-relative paths only for files that are expected to exist inside the current repository.
- Do not use absolute machine-specific paths such as `/Users/<name>/...` in shared guidance, skills, or rules.
- Do not rely on the current working directory to resolve canonical shared resources.

## Shared Baseline Rules

- Treat `~/.local/share/agents/` as the canonical home for shared agent references and rule files.
- Refer to shared reference modules with explicit paths under `~/.local/share/agents/references/`.
- Refer to shared rule files with explicit paths under `~/.local/share/agents/codex/rules/` when the path itself matters.
- Refer to published shared skills with explicit paths under `~/.local/share/skills/`.

## Project Guidance Rules

- Point project `AGENTS.md` files directly at the relevant shared modules under `~/.local/share/agents/references/`.
- Load only the modules relevant to the current project or task.

## Maintenance Rules

- When editing shared docs or skills, update stale path references in the same change.
- Keep one canonical path form per resource family to avoid multiple resolution models.
- If a workflow depends on a standard installation location, state that location explicitly.
