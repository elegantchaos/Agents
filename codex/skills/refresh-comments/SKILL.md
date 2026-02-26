---
name: refresh-comments
description: Refresh code comments to match local AGENTS.md policy and linked guidance files. Use primarily as a one-time or infrequent modernization pass for older codebases, with fallback to ~/.local/share/agents/instructions/COMMON.md only when local guidance is missing or ambiguous.
---

# Refresh Comments

Refresh repository code comments using project-local guidance first.

Treat this as baseline cleanup for legacy code; rerun only for targeted stale areas or after major policy shifts.

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
- Open only files relevant to comment standards.
- Record unresolved references.

2. Audit comment targets:
- Type/class/struct comments
- Function/method comments
- Member/property comments
- Inline comments around subtle logic and non-obvious constraints

3. Reconcile and edit:
- Remove stale, redundant, or contradictory comments.
- Prefer intent/context (why, constraints, side effects) over restating symbol names.
- Keep comments concise and IDE-friendly.

4. Validate coherence:
- Ensure comments do not conflict with local `AGENTS.md`.
- Ensure fallback guidance was used only where local guidance is silent.
- Ensure comments still match actual behavior.

## Comment Rules

- Prioritize purpose, invariants, preconditions, and failure behavior.
- Keep inline comments sparse and reserved for subtle logic.
- Avoid ceremonial comments and obvious restatements.

## Output Checklist

Always report:

- Code files updated for comments
- Guidance sources used (local and fallback)
- Missing/ambiguous guidance references
- Any policy conflicts or assumptions
