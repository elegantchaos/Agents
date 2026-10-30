# Shared Agents Roadmap

Trial roadmap for Sam's curation. Last reconciled: **27 October 2026**.

This overview tracks shared agent capabilities and cross-project working habits.
Project features belong in each project's roadmap; detailed proposals and
delivery evidence stay with their owning repository and journal. This first
draft establishes the shape and known candidates, not an exhaustive task audit.

## You Are Here

Review reporting is updated from Bookish PR #119 feedback: focus on needed changes, retain known status only as necessary context, and lead codebase-effect sections with actions or a brief bold no-action sentence. Proposed full reviews name a concrete remaining need instead of listing review history. Added to PR #40; return point is its existing release prerequisite, merge and baseline refresh. See [the journal](extras/journal/2026-10-30-review-action-openings.md). The review skill now requires a change-driven impact investigation across the whole codebase even for diff reviews; Bookish PR #119 supplied a reproduced cross-package import defect and concrete rendering/query follow-ups. Further behavioural evaluation remains open.

Calendar access follow-up: the summaries skill requests outside-sandbox calendar execution through each runtime's approval flow, without a standing command rule. The companion AgentTools fix makes queries request their own permission by default, adds `--no-prompt`, removes `authorize`, and improves failure diagnostics. Return point: review both PRs, release the AgentTools change before activating this guidance, then merge and refresh the baseline plugin; installed-plugin rollout is not part of this source change. See [the journal](extras/journal/2026-10-30-calendar-approval.md). This does not resume the broader approval-rule redesign.

**Current focus: make new worktrees ready for sandboxed development through AgentTools.**

Worktree setup and dependency preparation are delegated to `agt worktree create` and `agt prepare`. The command implementation lives in AgentTools; the baseline Git and Swift validation skills own authorization, runtime integration and the TDD workflow. Merge Agents #38 only after an AgentTools release containing the commands is available: COMMON.md is read directly from this checkout, so plugin installation cannot defer activation of its new rule. Return point: release AgentTools, merge the shared guidance, then refresh the baseline/Swift plugins and generated rules and confirm a fresh Claude worktree can run targeted tests after one approved preparation step. Bookish supplies the integration fixture; its product source is unchanged.

The baseline and Swift plugins, AgentTools refresh/validation workflows, and
project journals already supply the working foundation. Recent work tightened
review evidence, design confirmation, commit identity and targeted test runs.
Bookish is now trying smaller work slices, explicit source reconciliation and
checkpoint-based upkeep. Evaluate that trial before promoting its method into
shared skills. This repository also reads and updates its own roadmap during work.

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
| **Project continuity** | Trial. Bookish keeps a compact overview plus a current work plan for slices, maintenance opportunities and source dispositions. Evaluate completed work before promoting this into shared skills; no new tracking system or automatic synchronisation is selected. | [Records skill](plugins/baseline/skills/records/SKILL.md), [Bookish roadmap PR](https://github.com/elegantchaos/Bookish/pull/112) |
| **Stack task access** | Parked. First inspect Stack's existing access when resumed, then choose the smallest useful App Intents, CLI and/or MCP extension for reading and writing tasks. Keep captured task detail in Stack and link it to project workstreams. Implementation belongs in Stack; reusable agent guidance belongs here. | This roadmap; detailed proposal not yet written |
| **Guidance and review quality** | The review skill now requires structural reasoning about concepts, responsibilities and ownership, with search inventories kept in working notes, and inspects existing validation evidence without routine reruns; PRs default to ready for review ([evidence and changes](extras/journal/2026-10-28-review-design-analysis.md)). Next: evaluate subsequent reviews for justified conclusions about still-used obsolete machinery, simplification and duplicated knowledge; metadata checks alone do not close that behavioural evaluation. | [Journal index](extras/journal/index.md), [baseline plugin](plugins/baseline/README.md), [Swift plugin](plugins/swift/README.md) |
| **Validation and resource maintenance** | Worktree setup and dependency preparation use AgentTools, with explicit permission for any outside-sandbox setup. Targeted tests remain on the canonical validation path. Release and fresh Claude acceptance remain the adoption boundary. | [Preparation workflow](extras/journal/2026-10-29-worktree-preparation.md), [Targeted test runs](extras/journal/2026-10-27-targeted-test-runs.md), [maintenance instructions](README.md#maintenance) |

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

## Next Slices

| Slice | Finish condition | State |
| --- | --- | --- |
| Prepare worktrees before TDD | AgentTools creates worktrees, initialises submodules and resolves dependencies into validation's directories; shared guidance names the commands and preserves authorization boundaries. | Implemented with AgentTools integration evidence in the linked journal. Release, plugin installation and fresh Claude runtime acceptance remain outstanding. |
| Establish the Bookish trial | Its roadmap, current work plan, source register and project read/update instruction are reviewable; unresolved historical reconciliation is explicit. | In progress in Bookish PR #112. |
| Evaluate upkeep on real work | After the first few completed slices, check whether a fresh chat can choose the next task and account for carried findings using current records. Record missed work, excessive granularity or repeated history scans. | Planned after trial use. |
| Refine shared guidance | Use those results to propose a small addition to the existing records workflow, if useful; implement and validate through the normal skill process once agreed. | Parked pending evidence; no shared skill changes now. |
| Investigate Stack access | When scheduled, inventory current access and identify the minimum useful read/write capability before choosing App Intents, CLI or MCP. | Parked at Sam's request. |

Only the next slice needs a detailed checklist. Split work where outcomes,
dependencies or verification differ. Attach related maintenance to the boundary
it improves when it fits the scope; a substantial refactor gets its own slice
and explicit dependency. Do not turn every opportunity into a release blocker.

## Trial Upkeep And Source Closure

- Read the overview when orienting shared work; update the affected row when
  starting, finishing, interrupting or resuming an initiative.
- Record why work paused, where its implementation lives, and the concrete step
  or condition for returning. Keep one primary focus and distinguish parked work
  from a dependency that genuinely blocks progress.
- Sam curates priorities. Newly captured thoughts are candidates, not automatic
  commitments. Keep detailed task state in its owning tool or implementation plan.
- Close each action in a review/plan as resolved with evidence, superseded by a
  named replacement, carried to a live home with a return point, or declined by
  Sam with a reason. Uncertain actions stay pending. Keep implementation,
  merge and outstanding acceptance distinct.
- Once every action has a disposition, mark the source reconciled in the current
  work record and exclude it from routine intake. Keep historical reviews and
  journals intact; close completed phases of living plans while preserving useful
  explanation and a current remaining-work section. Required guidance and binding
  design/decision reads still apply.
- Inspect new evidence since a dated commit/PR/journal checkpoint, plus relevant
  pending sources. Advance the checkpoint only when new actions are registered
  or disposed of. A regression creates new intake, with links to old evidence
  only where needed.

The project-specific AGENTS instruction activates this trial in the shared
repository. It does not install a new rule in other projects. No shared skill,
plugin, automatic Stack access or task synchronisation is changed.

**Initial source set:** this roadmap, its linked journal entries and the journal
index as of main `265402c`, plus this upkeep follow-up. Historical candidates in
the previous section are carried pending a current status check, not resolved.
The initial roadmap is delivered by [PR #34](https://github.com/elegantchaos/Agents/pull/34).
Other journal-index history has not had a complete action reconciliation; that
bounded initial debt remains explicit, rather than implying the whole backlog
was cleared. Future intake starts after that baseline and is recorded as work
progresses. Record the next processed head when this follow-up merges.

## Reconciliation Basis

Shared repository README and journal index, selected source entries for the
parked candidates, recent recorded guidance work, local branch/worktree state
and open PRs on 27 October. No open Agents PR was returned at the initial check.
Baseline: `65a6ead`. This is a scoped planning draft; Stack's code, data and live
capabilities were not inspected, and the shared backlog was not audited in full.
