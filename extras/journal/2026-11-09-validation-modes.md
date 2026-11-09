# Validation Modes

- [AgentTools #14](https://github.com/elegantchaos/AgentTools/pull/14) replaces `--fast` with three modes. `--target` checks live edits. Bare `agt validate` checks committed changes against the merge base with `main`. `--full` checks the complete product. Change-scoped and full runs build a pinned commit in a paired validation worktree and refuse a dirty checkout.
- Without this update, the installed skill would fail on `--fast` and, worse, its merge gate would weaken silently: `--background` and `--wait` without `--full` run and accept change-scoped results, and a change-scoped run with no relevant changes reports success while validating nothing.
- Updated `swift:validation`'s workflow and Codex default prompt. Development uses `--target`, committed checks use bare `agt validate`, and the merge gate uses `--full --background` and `--wait --full`. Replaced the working-tree fingerprint and stale-result text with commit-based results, and corrected the claim that preparation stops background validation. An empty change-scoped pass must never be reported as full validation.
- The skill tells agents to update `agt` once when `agt validate --help` lacks `--full`. Merge only after the AgentTools release that adds the modes. Swift plugin 0.11.4.
- Full validation's submodule wording follows AgentTools #14 as submitted, where `changed` behaves as `always`. The review on that PR questions the default; revisit this paragraph if it changes.

## Follow-up

AgentTools #14 settled the submodule rules, and the skill now matches them. By default, full validation tests a submodule's packages only when the branch moved its commit since the merge base with `main`. Committed validation refuses submodule commits that no remote branch contains, so agents push submodule work, for example to its `integration/<app>` branch, before validating. An empty change-scoped run is recorded as finding nothing, and `--wait` rejects it, instead of reporting success.
