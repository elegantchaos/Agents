# Shared Agents Roadmap

Roadmap for Sam's curation. Last reconciled: **12 November 2026**.

This overview tracks the ongoing evolution and maintenance of shared agent guidance and capabilities owned by the Agents repository. It records current priorities, possible improvements and return points as they change; it does not prescribe a release schedule or a finished end state. Other projects appear only where their work provides evidence or a dependency for shared guidance. Their features and delivery plans belong in their own roadmaps.

## You Are Here

**Current focus: confirm worktree preparation in a fresh Claude session.**

Agents #40 merged the calendar guidance, review reporting changes and session tool update rule. Worktree preparation is next: Agents #38 is merged and the installed AgentTools has `agt worktree create` and `agt prepare`. The baseline and Swift plugins and generated rules were refreshed on 6 November. Return point: confirm a fresh Claude worktree can run targeted tests after one approved preparation step. Bookish supplies the integration fixture.

The baseline and Swift plugins, AgentTools refresh/validation workflows, and
project journals already supply the working foundation. Recent work tightened
review evidence, design confirmation, commit identity and targeted test runs.
Evaluate project experience with smaller work slices, source reconciliation and checkpoint-based upkeep before promoting those methods into shared skills. This repository also reads and updates its own roadmap during work.

## Continuing Aims

- Consistent, useful guidance across supported agent runtimes, maintained at one
  canonical source and installed through the existing refresh workflow.
- Reliable implementation and reviews: clear ownership, meaningful validation,
  precise evidence and explicit gaps, without needless ceremony.
- Continuity between chats and projects: quickly recover current focus, parked
  work, dependencies and the concrete next step.
- Shared guidance for accessing the tools Sam uses to capture and organise work, where those tools support agent access.

## Workstreams And Return Points

| Workstream | State and next boundary | Home |
| --- | --- | --- |
| **Project continuity** | Evaluate experience with compact overviews, work slices and source dispositions before deciding whether to change shared records guidance. Bookish provides evidence for that evaluation; no new tracking system or automatic synchronisation is selected. | [Records skill](plugins/baseline/skills/records/SKILL.md), [Bookish roadmap PR](https://github.com/elegantchaos/Bookish/pull/112) |
| **Skill distribution** | Proposed direction: package each standalone language skill as a language plugin. Existing submodules and runtime symlinks remain in use until a migration is planned and implemented. | [Shared skills](README.md#shared-skills) |
| **Stack task access guidance** | Parked. When Stack agent access is scheduled, assess whether reusable guidance is needed here; access implementation belongs in Stack. | This roadmap |
| **Guidance and review quality** | Evaluate subsequent reviews for justified conclusions about still-used obsolete machinery, simplification and duplicated knowledge; metadata checks alone do not close that behavioural evaluation. The personal-voice decision candidate awaits confirmation. | [Journal index](extras/journal/index.md), [baseline plugin](plugins/baseline/README.md), [Swift plugin](plugins/swift/README.md) |
| **Validation and resource maintenance** | Plugins and generated rules refreshed on 6 November. Next, confirm fresh Claude worktree preparation and targeted validation. The Swift validation skill's update for AgentTools' targeted, change-scoped and full modes waits on that AgentTools release. Shared rules stay in use under both runtimes' auto modes; Claude Code rules are a candidate slice. | [Preparation workflow](extras/journal/2026-10-29-worktree-preparation.md), [maintenance instructions](README.md#maintenance) |

## Parked Candidates To Recheck

These come from historical journal entries; they need a current status check
before being treated as live implementation tasks.

- **Environment bootstrap:** settle ownership and ordering across Homebrew,
  Mint, asdf, Python and homebrew-xpkg before automating more setup. The
  [8 October journal](extras/journal/2026-10-08.md) explicitly defers it.
- **SwiftUI diagnostic helpers:** a runtime-selectable view-change logging helper
  was explored in that same journal. Check whether its proposed external package
  exists and is useful before scheduling integration.

## Current And Parked Work

| Slice | Finish condition | State |
| --- | --- | --- |
| Require skill coverage in reviews | The review skill makes reading every applicable skill and checking its checklist a precondition of any verdict, and summaries name the skills read. | Guidance updated; both baseline manifests are 0.8.34. [Journal](extras/journal/2026-11-12-review-skill-coverage.md). Return point: install the merged baseline, then check later reviews name their skills and report checklist deviations. |
| Revise decisions in place | The records skill defaults to revision in place with confirmation and a supersession alternative; every record section stays within the general policies future design and implementation must respect, their scope and essential reasons. | Guidance updated with its record shape and compliance checklist; both baseline manifests are 0.8.33. [Journal](extras/journal/2026-11-11-decision-revision-policy.md). Runtime installation remains due after merge. Return point: install the merged baseline and remove Bookish's redundant project override. |
| Prepare worktrees before TDD | AgentTools creates worktrees, initialises submodules and resolves dependencies into validation's directories; shared guidance names the commands and preserves authorization boundaries. | Merged in Agents #38, released in AgentTools and plugins refreshed. Fresh Claude runtime acceptance remains outstanding. |
| Land Agents #40 | Calendar, review and session tool guidance merged, and the baseline plugin refreshed. | Done; merged and installed plugins refreshed on 6 November. |
| Adopt AgentTools validation modes | `swift:validation` uses `--target` for live edits, bare `agt validate` for committed changes and `--full` / `--wait --full` for the merge gate, merged with the AgentTools release that adds them and the Swift plugin refreshed. | Merged in Agents #45 after [AgentTools 4.0.0](https://github.com/elegantchaos/AgentTools/releases/tag/v4.0.0) was released and installed ([journal](extras/journal/2026-11-09-validation-modes.md)). Return point: refresh the installed Swift plugin from a shared checkout that contains #45. |
| Migrate standalone language skills to plugins | Plan and migrate the JavaScript, Python and Ruby skills to language plugins, including supported-runtime installation and guidance updates. | Candidate; inspect ownership and migration details before implementation. Existing links remain in use. |
| Add Claude Code rules | Shared rules also produce Claude Code permission allow rules, installed by the refresh workflow, with guidance and decision 0003 updated to cover both runtimes. | Candidate. Sam now runs both runtimes with auto-approval and keeps the rules, settling the question parked in the [29 September journal](extras/journal/2026-09-29.md): allow rules still apply in auto mode. Decide the source format and how Claude settings are written before implementation. Matching commands skip review in both runtimes, so keep rules narrow. |
| Move SwiftUI trace analysis to AgentTools | Assess and move the SwiftUI trace-analysis script into an AgentTools command, then update the Swift skill and its installation guidance. | Candidate; inspect the script and command boundary before implementation. `ensure-agt.sh` remains a bootstrap exception. |
| Evaluate upkeep on real work | Use completed project work as evidence to check whether a fresh chat can choose the next task and account for carried findings using current records. Record missed work, excessive granularity or repeated history scans. | Planned; Bookish provides one source of evidence. |
| Refine shared guidance | Use those results to propose a small addition to the existing records workflow, if useful; implement and validate through the normal skill process once agreed. | Parked pending evidence; no shared skill changes now. |
| Assess Stack access guidance | Determine whether agent access needs shared guidance once the integration is scheduled. | Parked at Sam's request. |

Use bounded slices when they help make an improvement reviewable. Split work where outcomes, dependencies or verification differ, and attach related maintenance where it fits. Revisit priorities and return points as experience suggests; individual changes can be completed without treating the roadmap itself as a project to finish.

## Upkeep And Source Closure

- Read the overview when orienting shared work; update the affected row when
  starting, finishing, interrupting or resuming an initiative.
- Keep one primary focus in You Are Here. Other work goes in the tables, never as extra paragraphs above the focus. A change corrects any focus, return point or slice it makes false, and advances the reconciled date.
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

The project-specific AGENTS instruction applies this upkeep to the shared repository. It does not install a rule in other projects.

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
Baseline: `65a6ead`. The shared backlog was not audited in full.
