# Public Skill Maintenance Scripts

These scripts support the repo-per-skill publication workflow.
The implementation is Swift-based; the existing script entry points are retained as Swift launchers for compatibility.

## Scripts

- `skills-public.swift`: shared Swift implementation for the maintenance commands
- `audit-skill.sh`: audit one skill or all skills for publication blockers
- `sync-skill-repos.sh`: clone or pull skill repositories into `~/.local/share/skills`
- `link-skill-repos.sh`: point `~/.agents/skills` and `~/.codex/skills` at the skill repo checkouts
- `status-skill-repos.sh`: report missing checkouts, dirty repos, branch drift, and symlink mismatches

## Metadata

All scripts read `codex/skills/public-skill-registry.json` from the repository root.

## Local Checkout Home

By default, public skill repositories are checked out under `~/.local/share/skills`.
Set `SKILLS_HOME` to override this location.

## Typical Usage

```bash
scripts/skills-public/sync-skill-repos.sh --all
scripts/skills-public/link-skill-repos.sh
scripts/skills-public/status-skill-repos.sh
scripts/skills-public/audit-skill.sh --all
```
