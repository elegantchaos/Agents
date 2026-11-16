# Worktree Attachment

Sam confirmed that AgentTools should continue to own worktree creation and requested an explicit instruction to attach the checkout it produces. The shared baseline now names the project's `.worktrees/<tree>` location and Codex attachment step. The Git skill specifies `attach_worktree(path: <absolute checkout path printed by agt>)`, preserves explicit-path operation when attachment is unavailable or fails, and requires reporting a higher-priority creation conflict before creating elsewhere.

The current Codex app instructions require its own `create_worktree` tool, whose exposed arguments have no destination path. Shared guidance cannot override that instruction. Reusing an existing project-local worktree and attaching it succeeded in this session; creation through AgentTools followed by attachment was not exercised.

At Sam's request, this change joins [Agents #47](https://github.com/elegantchaos/Agents/pull/47) on `feature/review-skill-coverage`. The PR's existing baseline 0.8.34 version bump covers these additional unpublished changes. Runtime installation remains due after merge. The temporary `feature/agt-worktree-attachment` branch has no unique commits and was not used for edits.

Validation covers whitespace, plugin manifests, skill metadata and the changed guidance's consistency. No application code changed, so builds and application tests are unnecessary. A full resource refresh, rule sync and AGENTS regeneration are outside this focused change.
