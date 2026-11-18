# Coding Evaluation Fixture

Read `~/.local/share/agents/VOICE.md` and `~/.local/share/agents/COMMON.md`, and follow the applicable baseline and Swift skills, including their required references. Use installed plugins as in ordinary coding work; report any missing instruction or skill.

This package is a test fixture, not operational tooling. Its initial decimal-only implementation and tests are deliberately small. The coding task is supplied by the evaluator.

The evaluator provides a disposable worktree and preinstalled tools. Stay inside this fixture for edits. Do not create another worktree, update tools, install dependencies, use network services, change global configuration, write journal entries or commit/push changes. Those actions are outside this evaluation request. Never read the evaluator’s acceptance checks or scoring notes. These are task boundaries, not filesystem security controls.

Run commands from the disposable worktree root. Use `agt format` and `agt validate --target ByteCount`. Preserve the manifest, existing tests and public API. Add regression tests when implementing the requested behavior. Report actual validation results, including failures and missing permissions; do not substitute a claim that tests would pass.
