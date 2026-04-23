---
name: refresh
description: Refresh shared agent resources and then refresh the current project's AGENTS.md. Use for regular shared-maintenance passes, project AGENTS.md regeneration, public skill sync/link/status checks, and shared guidance review.
---

# Refresh

Run one coherent maintenance pass:

- `global`: update and verify shared resources under `~/.local/share/agents`, including the shared repository, public skill submodules, runtime skill links, shared rules, scripts, references, and principles
- `research`: optionally compare selected skills and guidance against trusted primary or high-quality source material, then propose or implement sensible revisions
- `local`: refresh the current project's `AGENTS.md` from the shared baseline while preserving project-specific rules and generating `Project Specific Rules`, `Standard Rules`, and `Skills`

The default path is `global` followed by `local`.
Run `research` only when requested, when maintaining the shared agents repo itself, or when there is concrete evidence that a skill may be stale.

## Use This Skill When

- running a regular daily or automation-friendly agent maintenance pass
- rebuilding or refreshing one repository's `AGENTS.md`
- reviewing the shared agents repository itself
- syncing, linking, auditing, or checking published shared skill repositories
- cleaning up shared rules, shared references, or agent-maintenance workflows

## Workflow

1. Identify the target project. If the working directory is `~/.local/share/agents`, treat the shared agents repo as both the global source and local target.
2. Read `references/global-mode.md` for the shared-resource maintenance pass.
3. If research is requested or justified, read `references/research-phase.md`.
4. Read `references/local-mode.md` for the project `AGENTS.md` refresh pass.
5. Before finishing, read `references/final-checklist.md` for the required response items.

## Skill References

When you mention other skills, follow these practical rules to avoid wasting context:
  - Mention skills explicitly when they are genuinely repo-relevant.
  - Prefer a short conditional instruction over a bare link dump.
  - Keep operational skill references centralized in `Skills`; avoid scattering them elsewhere except for the required regeneration note.
  - Do not summarize the skill in `AGENTS.md`; let the skill own its own detail.

Do not add skill references just for discovery. Assume that the available list of skills is already known.
Point to skills to support selection, not invite eager loading.
Use skill names, not explicit file paths.

Examples:
- Good: `Use the swiftui-pro skill for SwiftUI view work.`
- Bad: `Also consider these 12 related skills...`

## Public Skill Maintenance

The public skill sync/link/status workflow is part of the global pass.
Use `agent-tools` from the shared agents repository root:

```bash
swift run agent-tools skills sync --all
swift run agent-tools skills link
swift run agent-tools skills status
swift run agent-tools skills audit --all
```

Use audit for publication readiness, major edits, or explicit audit requests.
For routine daily refreshes, `sync`, `link`, and `status` are usually sufficient.

## References

- `references/global-mode.md`: shared-resource maintenance pass, public skill sync/link/status, shared rules cleanup, and verification
- `references/research-phase.md`: optional source-comparison workflow for improving skills and shared guidance
- `references/local-mode.md`: project `AGENTS.md` rebuild workflow, three-section output rules, stack detection, and baseline verification
- `references/final-checklist.md`: required response items for the unified refresh workflow
