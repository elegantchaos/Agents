---
name: refresh-public-skills
description: Audit, sync, and relink the published shared skill submodules managed by this repository.
---

# Refresh Public Skills

Manage the submodule-based publication workflow for skill repositories coordinated by this repository.

This skill treats the current repository as the control plane.
Each public skill repository under `elegantchaos/` is mounted into the top-level `skills/` directory as a git submodule.

## Inputs

- Skill submodules under `skills/`
- Front matter in each discovered `SKILL.md`
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
- Initialize one skill or all skills to the git revisions recorded by the parent repository.
- Target skills by runtime name once initialized, or by submodule directory name/path.

3. `link`
- Point `~/.agents/skills` at the discovered skill directories inside the submodules.
- Use the front matter `name:` field from `SKILL.md` as the runtime skill name.
- Fail if two discovered skills resolve to the same runtime name.
- Keep repo-local maintenance skills linked from `skills/` where needed.

4. `status`
- Report uninitialized submodules, dirty repos, branch drift, and runtime symlink mismatches.

## Required Workflow

1. Run `sync` to ensure the skill submodules are initialized to the recorded revisions.
2. Run `audit` before first publication and after major edits.
3. Sanitize portability findings before treating a skill as publish-ready.
4. Run `link` so runtime skill directories point at the repo-local submodule checkouts.
5. Run `status` to catch drift or broken symlinks before relying on the local runtime setup.

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
- discovered runtime name and source path for each skill
- blockers or portability findings
- files added or updated
- any manual follow-up required before publication
