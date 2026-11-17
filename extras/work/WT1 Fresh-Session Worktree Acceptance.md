# WT1: Fresh-Session Worktree Acceptance

- **Status:** Planned
- **Depends on:** nothing
- **Sources:** [Worktree preparation](../journal/2026-10-29-worktree-preparation.md), [Worktree attachment](../journal/2026-11-16-worktree-attachment.md), [Agents #38](https://github.com/elegantchaos/Agents/pull/38), [Agents #47](https://github.com/elegantchaos/Agents/pull/47)

## Finish Condition

- In a fresh Claude Code session, `agt worktree create` followed by at most one approved preparation step lets `agt validate --target <target>` run targeted tests in the new worktree. Bookish supplies the fixture.
- In a fresh Codex session, `agt worktree create` followed by `attach_worktree` gives an attached workspace at the checkout path `agt` printed.
- The results are journalled, and the Git skill is corrected wherever either flow departs from it.

## Notes

The guidance is merged and installed; only these runtime checks are outstanding. Attaching an existing project-local worktree in Codex already succeeded. Codex's own instructions prefer its `create_worktree` tool, which takes no destination path; record how that conflict plays out rather than working around it.
