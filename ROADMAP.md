# Shared Agents Roadmap

Draft for Sam's curation. Last reconciled: **27 October 2026**.

This overview tracks shared agent capabilities and cross-project working habits.
Project features belong in each project's roadmap; detailed proposals and
delivery evidence stay with their owning repository and journal. This first
draft establishes the shape and known candidates, not an exhaustive task audit.

## You Are Here

**Current focus: establish a useful overview of shared work and parked ideas.**

The baseline and Swift plugins, AgentTools refresh/validation workflows, and
project journals already supply the working foundation. Recent work tightened
review evidence, design confirmation, commit identity and targeted test runs.
The next proposed step is to curate this roadmap and settle a lightweight upkeep
rule that helps future chats recover interrupted work.

**Stack integration is parked.** Sam uses Stack to capture tasks and thoughts
across projects. Agents should eventually be able to read and write that data;
extending Stack's access is not scheduled now and blocks no current project work.

## Long-Term Goals

- Consistent, useful guidance across supported agent runtimes, maintained at one
  canonical source and installed through the existing refresh workflow.
- Reliable implementation and reviews: clear ownership, meaningful validation,
  precise evidence and explicit gaps, without needless ceremony.
- Continuity between chats and projects: quickly recover current focus, parked
  work, dependencies and the concrete next step.
- Access to the tools Sam actually uses for capturing and organising work,
  including Stack, without maintaining competing task lists.

There is no application-style MVP or new release commitment for this roadmap.
The next proposed milestone is useful project continuity with the existing
Markdown records. Stack access can follow when that integration is scheduled.

## Workstreams And Return Points

| Workstream | State and next boundary | Home |
| --- | --- | --- |
| **Project continuity** | Draft. Bookish is trying a compact roadmap with a current-focus pointer, workstreams and explicit return points. Evaluate that use before introducing shared upkeep guidance; no new tracking system or automatic synchronisation is selected. | [Records skill](plugins/baseline/skills/records/SKILL.md), [Bookish roadmap PR](https://github.com/elegantchaos/Bookish/pull/112) |
| **Stack task access** | Parked. First inspect Stack's existing access when resumed, then choose the smallest useful App Intents, CLI and/or MCP extension for reading and writing tasks. Keep captured task detail in Stack and link it to project workstreams. Implementation belongs in Stack; reusable agent guidance belongs here. | This roadmap; detailed proposal not yet written |
| **Guidance and review quality** | Ongoing. Recent rules are delivered in repository guidance. Evaluate agent behaviour on real work before adding further rules; use concrete failures and keep proposed changes separate from current guidance. | [Journal index](extras/journal/index.md), [baseline plugin](plugins/baseline/README.md), [Swift plugin](plugins/swift/README.md) |
| **Validation and resource maintenance** | Existing workflow. Keep tests on the canonical validation path and shared resources maintained through AgentTools. New tooling needs a demonstrated gap. | [Targeted test runs](extras/journal/2026-10-27-targeted-test-runs.md), [maintenance instructions](README.md#maintenance) |

## Parked Candidates To Recheck

These come from historical journal entries; they need a current status check
before being treated as live implementation tasks.

- **Environment bootstrap:** settle ownership and ordering across Homebrew,
  Mint, asdf, Python and homebrew-xpkg before automating more setup. The
  [8 October journal](extras/journal/2026-10-08.md) explicitly defers it.
- **Approval-rule workflow:** revisit whether runtime auto-review changes the
  useful scope of generated rules. The [29 September journal](extras/journal/2026-09-29.md)
  records an unresolved direction; it does not authorise changes now.
- **SwiftUI diagnostic helpers:** a runtime-selectable view-change logging helper
  was explored in that same journal. Check whether its proposed external package
  exists and is useful before scheduling integration.

## Proposed Upkeep

- Read the overview when orienting shared work; update the affected row when
  starting, finishing, interrupting or resuming an initiative.
- Record why work paused, where its implementation lives, and the concrete step
  or condition for returning. Keep one primary focus and distinguish parked work
  from a dependency that genuinely blocks progress.
- Sam curates priorities. Newly captured thoughts are candidates, not automatic
  commitments. Keep detailed task state in its owning tool or implementation plan.
- Remove completed context once the journal supplies the history. Reconcile
  later resolutions before reviving an old proposal.

These are draft maintenance rules, not installed skill or runtime instructions.
Adopting a shared read/update rule is separate work after the shape is agreed.
No plugin change, automatic Stack access, or task synchronisation is implemented.

## Reconciliation Basis

Shared repository README and journal index, selected source entries for the
parked candidates, recent recorded guidance work, local branch/worktree state
and open PRs on 27 October. No open Agents PR was returned at the initial check.
Baseline: `65a6ead`. This is a scoped planning draft; Stack's code, data and live
capabilities were not inspected, and the shared backlog was not audited in full.
