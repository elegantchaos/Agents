# Targeted Test Runs

A Bookish session ran its red/green TDD steps with `swift test --filter` instead of `agt validate`. The nested SwiftPM sandbox failed inside the agent sandbox, and the session stepped outside the sandbox to get round it, although `agt` already turns those inner sandboxes off. Its final validation did use `agt`.

The skills left a gap at that moment. `baseline:standards` requires running the failing test first but does not say how. `swift:testing` defers workflow elsewhere. `swift:validation` described itself as post-change validation, triggered when code has changed, so a test run before the implementation changed did not look like its job, and the agent fell back on a generic runner.

`swift:validation` now covers every test run, red and green steps included: its description and triggers say so, its workflow says to run tests only through `agt validate --target` (or `--fast`), never `swift test` or `xcodebuild` directly, and a blocked `agt` needs the user's permission before any direct-runner fallback. The standards testing reference adds that tests run through the project's canonical validation command in its narrowest targeted mode. Baseline 0.8.18, Swift 0.11.2.

Considered and set aside: a `--filter` option for `agt validate`. Whole-target runs in Bookish take seconds, dominated by the build, and a filtered run would need guarding so it never counts as validation. Worth revisiting for a target with slow tests.
