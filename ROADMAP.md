# Shared Agents Roadmap

Where the shared agent guidance is going: what it is for, what is in flight, what comes next and what is delivered. Each piece of open work has a [work item](extras/work/README.md), which owns its detail; history is in the [journal](extras/journal/index.md) and binding choices are in the [decision log](extras/decisions/).

This repository owns guidance and capabilities shared across projects. It has no release schedule or finished end state. Other projects appear only where their work provides evidence or a dependency for shared guidance; their own plans belong in their own roadmaps.

Sam curates priorities. A proposed item stays proposed until Sam confirms it, and newly captured ideas do not become commitments automatically.

## Aims

- Consistent, useful guidance across supported agent runtimes, maintained at one canonical source and installed through the refresh workflow.
- Reliable implementation and reviews: clear ownership, meaningful validation, precise evidence and explicit gaps, without needless ceremony.
- Continuity between chats and projects: quickly recover the current focus, parked work, dependencies and the concrete next step.
- Shared guidance for the tools Sam uses to capture and organise work, where those tools support agent access.

## Now

| Item | Status |
| --- | --- |
| [RP1: Roadmap And Work Items Trial](extras/work/RP1%20Roadmap%20And%20Work%20Items%20Trial.md) | Started |
| [WT1: Fresh-Session Worktree Acceptance](extras/work/WT1%20Fresh-Session%20Worktree%20Acceptance.md) | Planned |

RP1 runs alongside other work: it collects evidence as the pattern is used. Return point: WT1, starting with a fresh Claude Code session against the Bookish fixture.

## Next

In rough order of need.

| Item | Status |
| --- | --- |
| [RQ1: Review Quality Evaluation](extras/work/RQ1%20Review%20Quality%20Evaluation.md) | Planned |
| [CC1: Claude Code Allow Rules](extras/work/CC1%20Claude%20Code%20Allow%20Rules.md) | Proposed |
| [TR1: SwiftUI Trace Command](extras/work/TR1%20SwiftUI%20Trace%20Command.md) | Proposed |
| [LP1: Language Skills As Plugins](extras/work/LP1%20Language%20Skills%20As%20Plugins.md) | Proposed |

## Later

Ideas without an item. Check each one's current status before creating an item for it.

- **Stack access guidance:** parked at Sam's request. When Stack agent access is scheduled, assess whether reusable guidance is needed here; the access itself belongs in Stack.
- **Environment bootstrap:** settle ownership and ordering across Homebrew, Mint, asdf, Python and homebrew-xpkg before automating more setup. Deferred in the [8 October journal](extras/journal/2026-10-08.md).
- **SwiftUI diagnostic helpers:** a runtime-selectable view-change logging helper, explored in the same journal. Check whether its proposed external package exists and is useful first.

## Delivered

What the shared guidance provides now. The journal holds the detail and evidence.

- **Local inference and evaluation:** the [operating guide](extras/documentation/Local%20Inference.md) records the restricted-account Ollama service; the [evaluation procedure](extras/documentation/Coding%20Harness%20Evaluation.md) provides a qualified Swift fixture and fixed prompts for local/hosted Claude Code and Codex. Model coding scores and Desktop local routing remain unestablished. See [LI1](extras/work/Done/LI1%20Local%20Inference%20And%20Evaluation.md).
- **Distribution:** the `baseline` and `swift` plugins, standalone language skills linked as submodules, and `agt refresh` installing them in Claude Code and Codex with shared sandbox and rule configuration. See decisions [0002](extras/decisions/0002-language-skills-and-plugins.md) and [0003](extras/decisions/0003-runtime-installation.md).
- **Shared baseline:** `COMMON.md`, required by each adopting project's `AGENTS.md`, with task-specific guidance in skills. See [decision 0005](extras/decisions/0005-shared-baseline.md).
- **Reviews:** decision coverage, skill coverage as a precondition of any verdict, action-first reporting and change-driven codebase-effect investigation. Correctness findings explain the trigger and impact, and optional second-pass findings are verified before they are reported as confirmed. Reports are saved in the project's reviews directory and pushed to the branch reviewed so another agent can act on them. See [Review evidence and coverage](extras/journal/2026-11-23-review-evidence-and-coverage.md) and [Review report handoff](extras/journal/2026-11-19-review-report-handoff.md).
- **Records:** design confirmation gates, decision records revised in place, journal and index rules, and permalinks for historical links, repaired by `agt links --fix-history`. See [Decision revision policy](extras/journal/2026-11-11-decision-revision-policy.md) and [Historical links](extras/journal/2026-11-16-historical-links.md).
- **Worktrees and validation:** `agt worktree create` and `agt prepare` for setup, Codex attachment of the resulting checkout, and `agt validate` with targeted, change-scoped and full modes. Fresh-session acceptance is WT1. See [Worktree preparation](extras/journal/2026-10-29-worktree-preparation.md) and [Validation modes](extras/journal/2026-11-09-validation-modes.md).
- **Calendar and session tools:** guidance merged in Agents #40.
- **Localisation:** generated string catalog symbols by default, text parameters and storage chosen by what callers pass and what the type does with the text, and the `defaultLocalization` that SwiftPM symbol generation needs. See [Generated localisation symbols](extras/journal/2026-11-18-generated-localisation-symbols.md).

## Keeping This Current

- Change Now, Next and Later when an item is created, started, parked or finished, in the same PR as that work. The [work item lifecycle](extras/work/README.md#lifecycle) says what else changes.
- Change Delivered when finished work changes what the shared guidance provides.
- Keep one return point in Now, naming the concrete next step.
