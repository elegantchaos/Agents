# Public Skill Maintenance Scripts

These scripts support the submodule-based shared skill workflow.
The implementation is Swift-based; the existing script entry points are retained as Swift launchers for compatibility.

## Scripts

- `skills-public.swift`: shared Swift implementation for the maintenance commands
- `audit-skill.sh`: audit one skill or all skills for publication blockers
- `sync-skill-repos.sh`: initialize or update the recorded submodule revisions under `skills/`
- `link-skill-repos.sh`: point `~/.agents/skills` at the discovered skill directories inside those submodules
- `status-skill-repos.sh`: report uninitialized submodules, dirty repos, branch drift, and symlink mismatches

## Discovery

The scripts treat `skills/` as the source of truth.
They search each submodule recursively for the first `SKILL.md`, then use the front matter `name:` field as the runtime skill name.
Duplicate skill names fail the run.

## Typical Usage

```bash
scripts/skills-public/sync-skill-repos.sh --all
scripts/skills-public/link-skill-repos.sh
scripts/skills-public/status-skill-repos.sh
scripts/skills-public/audit-skill.sh --all
```
