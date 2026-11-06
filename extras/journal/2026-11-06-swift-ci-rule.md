# Swift CI Rule

- ActionBuilderCore was renamed to SwiftWorkflowBuilder and released as v3.0.0. Its tool is now `swift-ci`, run as `swift ci generate`.
- Replaced the Codex allow rule for `mint install elegantchaos/ActionBuilderCore` with one for `elegantchaos/SwiftWorkflowBuilder`, keeping `tools.rules` sorted. That rule was the only live reference to the old name in the shared guidance. A historical mention in the 2026-10-07 journal entry stays as written.
- The runtime copy in `~/.codex/rules/tools.rules` still carries the old rule until `agt rules sync` runs after this merges.
