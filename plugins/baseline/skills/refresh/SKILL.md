---
name: refresh
description: Refresh shared agent resources and then refresh the current project's AGENTS.md. Use for regular shared-maintenance passes, project AGENTS.md regeneration, public skill sync/link/status checks, and shared guidance review.
---

# Refresh

Run one or more maintenance passes:

- `global`: update and verify shared resources under `~/.local/share/agents`, including the shared repository, public skill submodules, runtime skill links, shared rules, scripts, references, and principles
- `research`: optionally compare selected skills and guidance against trusted primary or high-quality source material, then propose or implement sensible revisions
- `local`: refresh the current project's `AGENTS.md` while preserving project-specific rules: `Project Specific Rules` and a combined `Standard Rules` section that locates shared content, requires `COMMON.md`, and selects relevant skills

The default path is `local`.
Run `global` when maintaining shared resources under `~/.local/share/agents` or when the shared agents repository itself needs updating.
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
- Keep operational skill references centralized in `Standard Rules`; avoid scattering them elsewhere except for the required regeneration note.
- Keep base skill instructions broad and prefer "Also use" for additive specialist skills.
- Do not narrow a skill to the current API that established its relevance; e.g: SwiftUI guidance applies to all SwiftUI code.
- Do not summarize the skill in `AGENTS.md`; let the skill own its own detail.

Do not add skill references just for discovery. Resolve relevant skills from the shared agents content, including skills supplied by plugins.
Point to skills to support selection, not invite eager loading.
Use skill names, not explicit file paths.

Examples:

- Good: `Also use the swift:swiftui skill for SwiftUI code.`
- Bad: `Also consider these 12 related skills...`

## Shared Resource Maintenance

The public skill and shared rules workflows are part of the global pass.
Use the `agt` command from the shared agents repository root. Start by running this skill's `scripts/ensure-agt.sh --update`, which installs the latest AgentTools release (and Mint, via Homebrew, if needed) and prints the path to `agt`. This needs network access:

```bash
agt refresh
agt rules status
agt rules sync
agt skills sync --all
agt skills link
agt skills status
agt skills audit --all
```

Use audit for publication readiness, major edits, or explicit audit requests.
For routine daily refreshes, `agt refresh` and `agt skills status` are usually sufficient.

Run `agt refresh` from the shared agents repository to sync and link skills, configure both runtimes' sandboxes, and install or refresh the shared plugins in Claude Code and Codex.

## References

- `references/global-mode.md`: shared-resource maintenance pass, public skill sync/link/status, shared rules cleanup, and verification
- `references/research-phase.md`: optional source-comparison workflow for improving skills and shared guidance
- `references/local-mode.md`: project `AGENTS.md` rebuild workflow, verbatim template rendering, project-sensitive skill selection, and baseline verification
- `assets/AGENTS.md`: canonical two-section output template; substitute only the project rules and skill bullets
- `references/final-checklist.md`: required response items for the unified refresh workflow
