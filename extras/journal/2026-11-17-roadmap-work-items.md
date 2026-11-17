# Roadmap Work Items

Agents #47 and #48 merged and baseline 0.8.35 was installed, leaving the roadmap's focus and several slice rows describing work that had already landed. Sam asked to tidy the roadmap on the assumption that AgentTools #17's `agt links` command is released, and asked whether the roadmap should follow the pattern Bookish adopted.

Sam chose to adopt Bookish's pattern without its release layer:

- Open work now lives in work items under `extras/work/`, one file per item, with a status, sources, a finish condition and, when finished, an outcome. Finished items move to `extras/work/Done/`. The README there owns the format and lifecycle.
- The roadmap holds the aims, the items in Now and Next, unitemised Later ideas and a Delivered section. It lists items directly; Bookish's release plan has no counterpart, since Agents has no releases.
- The upkeep, source-closure and reconciliation-basis sections are gone. Their job passes to the work item lifecycle, which keeps record updates in the same PR as the work and forbids PRs that only record another's merge.
- The two `AGENTS.md` roadmap rules are replaced by one pointing at the roadmap and the work item README.

## Reconciliation

Assuming AgentTools #17 is released, these slices are delivered and appear only in Delivered: historical links and the link command, skill coverage guidance, decision revision in place, worktree preparation and Codex attachment guidance, validation modes, and Agents #40. Removing Bookish's redundant decision-revision override is Bookish's own work.

The remaining work became items:

- WT1 combines the outstanding fresh-session checks for Claude Code worktree preparation and Codex creation with attachment.
- RQ1 takes the behavioural review-quality evaluation, including whether reviews now name and check their skills.
- RP1 replaces the upkeep evaluation and guidance refinement slices, and evaluates this pattern for the records skill.
- CC1, TR1, LP1 and VO1 carry the Claude Code allow rules, the SwiftUI trace command, the language plugin migration and the personal voice decision candidate, all still proposed.

Stack access guidance, environment bootstrap and SwiftUI diagnostic helpers stay as Later ideas without items.

## Validation

Documentation only. Every relative link in the changed files resolves; whitespace checks pass.
