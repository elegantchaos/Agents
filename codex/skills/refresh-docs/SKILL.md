---
name: refresh-docs
description: Refresh project documentation to match local AGENTS.md policy and any linked guidance files. Use as a recurring maintenance workflow to keep docs aligned with current behavior, with fallback to ~/.local/share/agents/instructions/COMMON.md only when local guidance is missing or ambiguous.
---

# Refresh Docs

Refresh repository documentation using project-local guidance first.

Run this regularly as part of normal maintenance when code, workflows, or commands change.

## Inputs

Load in this order:

1. Repository-local `AGENTS.md` at the project root.
2. Any local guidance files explicitly referenced by `AGENTS.md`.
3. Shared fallback baseline: `~/.local/share/agents/instructions/COMMON.md`.

If `AGENTS.md` is missing, use `~/.local/share/agents/instructions/COMMON.md` as temporary primary guidance and note the assumption.

## Policy Precedence

Apply guidance in this exact order:

1. Explicit local rules in `AGENTS.md`.
2. Rules from files linked or named by local `AGENTS.md`.
3. `~/.local/share/agents/instructions/COMMON.md` only for gaps or ambiguity.

Never allow fallback `COMMON.md` to override explicit local rules.

## Required Workflow

1. Build a guidance map:
- Extract linked/named guidance from `AGENTS.md`.
- Open only relevant docs/policy sources.
- Record unresolved references.

2. Audit documentation targets:
- `README` files, runbooks, contributing guides, architecture notes, and command/reference docs.
- Include docs affected by changed behavior.

3. Reconcile and edit:
- Remove stale claims and contradictory instructions.
- Keep procedure steps concrete, testable, and ordered.
- Use commands/paths that exist in the repository.

4. Validate coherence:
- Ensure updated docs do not conflict with local `AGENTS.md`.
- Ensure fallback guidance was used only where local guidance is silent.
- Ensure changed docs are internally consistent.

## Documentation Rules

- Keep docs factual, concise, and behavior-aligned.
- Prefer updating existing docs over adding new files unless a clear gap exists.
- Call out assumptions and platform constraints explicitly.

## Output Checklist

Always report:

- Documentation files updated
- Guidance sources used (local and fallback)
- Missing/ambiguous guidance references
- Any policy conflicts or assumptions
