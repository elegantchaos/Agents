---
name: refresh-agents
description: Legacy bootstrap skill for migrating from repo-local skill folders to the repo-based skill checkout layout under ~/.local/share/skills, then handing off to the published refresh-agents skill.
---

# Agents Refresh Bootstrap

This is a legacy compatibility copy of `refresh-agents`.

Use it only to migrate a machine from the old repo-local skill layout to the current repo-based skill layout.
After migration, the canonical skill lives at:

- `~/.local/share/skills/refresh-agents-skill/SKILL.md`

## When To Use This Bootstrap

Use this bootstrap when:

- an older `AGENTS.md` or local instruction still points at `codex/skills/refresh-agents/SKILL.md`
- `~/.agents/skills/refresh-agents` does not yet point to `~/.local/share/skills/refresh-agents-skill`
- the public skill repos have not yet been synced onto this machine

## Migration Goal

Set up the current shared-skill runtime so that:

- public skill repos are checked out under `~/.local/share/skills`
- `~/.agents/skills/*` points at those repo checkouts
- `~/.codex/skills/*` points at those repo checkouts
- future use of `refresh-agents` resolves to `~/.local/share/skills/refresh-agents-skill`

## Required Migration Workflow

Run these commands from the shared agents repo root:

```bash
scripts/skills-public/sync-skill-repos.sh --all
scripts/skills-public/link-skill-repos.sh
scripts/skills-public/status-skill-repos.sh
```

## Required Checks

After running the commands above, confirm:

- `refresh-agents` appears in the status output with `ok` symlinks
- `~/.agents/skills/refresh-agents` points to `~/.local/share/skills/refresh-agents-skill`
- `~/.codex/skills/refresh-agents` points to `~/.local/share/skills/refresh-agents-skill`

If those checks fail, report the exact blocker rather than continuing with a partial migration.

## After Migration

Once migration succeeds:

1. Use `~/.local/share/skills/refresh-agents-skill/SKILL.md` for all future agent refresh work.
2. Treat this bootstrap copy as compatibility-only.
3. Do not recreate repo-local copies of other published skills under `codex/skills/`.

## Notes

- This bootstrap exists so older checkouts can self-heal after pulling the latest shared agents repo.
- The canonical shared skill sources are now the published repos listed in `codex/skills/public-skill-registry.json`.
- The only repo-local skills that should remain under `codex/skills/` are local control-plane or bootstrap skills.
