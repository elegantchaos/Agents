# Full Validation Skips Documentation-Only Commits

Date: 2026-10-22

Working on Bookish PR #99, a documentation-only commit landed after full validation had
passed, and the guidance required running full validation again on the new head. Sam asked
for the rule to require full validation on the PR's latest commit that changes code, and not
to require a rerun for documentation-only changes.

Three places carried the final-head rule, and all now say the same thing:

- `COMMON.md`: merging waits for full validation on the PR's latest commit that changes more
  than documentation files.
- `baseline:git` `pull-requests.md`: record the result and its commit in the PR; rerun after a
  commit that changes code, tests, configuration or other build inputs, not after one that
  changes only guides, journal entries or decision records.
- `swift:validation` `workflow.md`: the same rule, and how to handle `agt validate --wait`,
  which fingerprints the exact tree and so reports a result as stale after a later
  documentation-only commit. Confirm with `git diff --name-only <validated-commit> HEAD`
  that only documentation files changed, and rely on the recorded result.

Documentation files means files outside the build, so doc comments in source files still
count as code changes. Baseline advances to 0.8.10 and swift to 0.11.1.

Validation: manual review of the changed text. No automated check covers these files. The new
plugin versions have not been installed.
