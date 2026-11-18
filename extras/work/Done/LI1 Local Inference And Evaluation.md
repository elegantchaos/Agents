# LI1: Local Inference And Evaluation

- **Depends on:** nothing
- **Sources:** [Local inference journal](../../journal/2026-11-18-local-inference.md), [archived Bionic PR](https://github.com/elegantchaos/Agents/pull/50)

## Finish Condition

The restricted-account Ollama setup is documented outside the journal, with evidence and operational gaps. A repeatable coding evaluation supports local and hosted Claude Code and Codex without automatically spending hosted credits. Its baseline and independent acceptance checks are qualified.

## Outcome

Added the [documentation index](../../documentation/README.md), [operating guide](../../documentation/Local%20Inference.md), [evaluation procedure](../../documentation/Coding%20Harness%20Evaluation.md), fixed prompts, a dependency-free Swift fixture and independent checks. The baseline passes 10 cases; the checks detect missing behavior and a reference implementation passes all 33. This establishes the procedure and fixture, not a model quality score. Bionic PR 50 is closed and its exact head is preserved by the published archive tag; useful evidence-checking guidance is retained. The journal records validation and remaining work.
