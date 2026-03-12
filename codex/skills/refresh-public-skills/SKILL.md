---
name: refresh-public-skills
description: Audit public skill repositories for publication readiness, sync their local checkouts, and link them into agent runtime directories.
---

# Refresh Public Skills

Manage the repo-per-skill publication workflow for skill repositories coordinated by this repository.

This skill treats the current repository as the control plane.
Each public skill repository under `elegantchaos/` is the shareable source of truth for one skill.

## Inputs

- Skill metadata in `codex/skills/public-skill-registry.json`
- Local skill repo checkouts under `~/.local/share/skills` by default
- Maintenance scripts in `scripts/skills-public/`

## Modes

1. `audit`
- Inspect one skill or all skills for publication blockers.
- Check for secrets, absolute local paths, host-specific assumptions, and portability issues.
- Classify each skill as:
  - `safe as-is`
  - `safe after sanitization`
  - `not suitable for public extraction`

2. `sync`
- Clone or pull one skill repo or all skill repos into the local checkout home.
- Update the registry's `last_synced_ref` field when a git commit is available.

3. `link`
- Point `~/.agents/skills` at the local skill repo checkouts.
- Keep local-only maintenance skills in this repository when there is no public repo checkout.

4. `status`
- Report missing local checkouts, dirty repos, branch drift, and runtime symlink mismatches.

## Required Workflow

1. Read the registry entry for each target skill.
2. Run `sync` to ensure local repo checkouts exist under `~/.local/share/skills`.
3. Run `audit` before first publication and after major edits.
4. Sanitize portability findings before treating a skill as publish-ready.
5. Run `link` so runtime skill directories point at the synced repo checkouts.
6. Run `status` to catch drift or broken symlinks before relying on the local runtime setup.

## Commands

Typical commands from the repository root:

```bash
scripts/skills-public/audit-skill.sh --all
scripts/skills-public/sync-skill-repos.sh --all
scripts/skills-public/link-skill-repos.sh
scripts/skills-public/status-skill-repos.sh
```

## Output Checklist

Always report:

- skills audited, synced, or linked
- classification or sync result for each skill
- blockers or portability findings
- files added or updated
- any manual follow-up required before publication
