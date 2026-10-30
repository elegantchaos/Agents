# Journal

- [2026-10-30 Session Tool Updates](2026-10-30-session-tool-updates.md): Every session updates `agt` and `rt` with Mint, so skills drop minimum tool versions; PR #40 review fixes, roadmap upkeep rule and normalised journal titles; baseline 0.8.29.

- [2026-10-30 Review Sections Lead With Actions](2026-10-30-review-action-openings.md): One report covers correctness and wider impact without repeating findings; codebase-effect sections lead with actions or brief no-action sentences, and diff reviews trace consequences across the whole codebase; no separate Follow-ups recap; baseline 0.8.31.

- [2026-10-30 Calendar Command Approval](2026-10-30-calendar-approval.md): Summaries guidance for runtime-approved calendar execution and automatic permission requests with `--no-prompt`; released in AgentTools 3.13.0; baseline 0.8.29.

- [2026-10-29 PR #38 Review Fixes](2026-10-29-pr38-review-fixes.md): Release-before-merge prerequisite, one-time bootstrap updates, approved removal of the blanket agt allow rule, and qualified runtime-sandbox evidence.

- [2026-10-29 Journal Index Normalised](2026-10-29-journal-index.md): PR #8 post-merge review; index reordered newest first with titled links throughout; unsourced research figures and journal path case left as open suggestions.

- [2026-10-29 Worktree Setup Before TDD](2026-10-29-worktree-preparation.md): AgentTools owns worktree conventions and dependency preparation; shared Git and Swift guidance owns authorization, TDD and runtime integration. Release and Claude acceptance remain the adoption boundary.

- [2026-10-28 Reviews Assess Design Consequences](2026-10-28-review-design-analysis.md): Trace concepts, responsibilities and ownership across affected boundaries; report structural reasoning with implementation evidence, keeping detailed search inventories in working notes. PRs default to ready for review; reviews inspect existing validation evidence without routine reruns, leaving full app validation to the merge gate; baseline 0.8.20.

- [2026-10-27 Decision Records Without Plans](2026-10-27-decision-records-no-plans.md): Decision records link design documents only and leave out details likely to go out of date, such as planned implementation, delivery order or status; voice greeting suits the context; baseline 0.8.19.

- [2026-10-27 Roadmap Trial And Source Reconciliation](2026-10-27-roadmap-upkeep.md): Smaller slices, finish conditions, explicit disposition of old actions and bounded upkeep checkpoints; project-local trial activated without shared skill changes.

- [2026-10-27 Shared Agents Roadmap](2026-10-27-roadmap.md): Draft overview of shared capabilities, project continuity and parked Stack task access, separated from Bookish product goals.

- [2026-10-27 Targeted Test Runs](2026-10-27-targeted-test-runs.md): Run every test, red/green steps included, through `agt validate --target`, never a direct runner; the validation skill's triggers now cover test runs during development; baseline 0.8.18, Swift 0.11.2.

- [2026-10-27 Commit Identity](2026-10-27-commit-identity.md): Commits carry the user's identity as author and committer, checked before committing, rewriting and pushing, so cloud sessions configured as the agent do not enter history; baseline 0.8.17.

- [2026-10-23 Explicit Voice Traits](2026-10-23-voice-traits.md): Replace the ambiguous character blend with named traits, explicit writing behavior and safeguards against performed toughness.

- [2026-10-23 Design Documentation Confirmation](2026-10-23-design-confirmation.md): Reviewable proposal and separate confirmation before design-document edits, with bounded scope and matching checklist, standards pointer and template; baseline 0.8.16.

- [2026-10-23 Compact Decision Records](2026-10-23-compact-decision-records.md): Distinct binding choices, compact conditional sections, sufficient context, linked design detail and a decision-record compliance checklist; baseline 0.8.15.

- [2026-10-23 Review: Design Guidance Against Datastore Design](2026-10-23-datastore-guidance-comparison.md): Preserve the conceptual overview and detailed-design structure; clarify repetition, subfolders, API references and background appendices; identify small mechanism sketches that strict rules would move.

- [2026-10-23 Design Document Guidance](2026-10-23-design-document-guidance.md): Root notes integrated into baseline records; expanded overview/detail structure, blank template, document boundaries, naming, location, Excalidraw diagrams and compliance checklist; matching baseline 0.8.14 manifests.

- [2026-10-23 Review: Design Document Shape](2026-10-23-design-document-review.md): Clarify intended design, essential constraints, outline, terminology and redesign context; recommend the baseline records skill as owner. Proposal and skills unchanged.

- [2026-10-22 Report Decision Deviations Only](2026-10-22-decision-review-reporting.md): Complete decision checking stays internal; reports omit compliance inventories and list only deviations and unresolved gaps; baseline 0.8.11.

- [2026-10-22 Full Validation Skips Documentation-Only Commits, And Worktrees Get Semantic Names](2026-10-22-docs-only-validation.md): Merging needs full validation on the PR's latest commit that changes more than documentation files; `COMMON.md`, `baseline:git` and `swift:validation` agree; worktrees are named after their task and branch; baseline 0.8.10, swift 0.11.1.

- [2026-10-22 Decision Record Shape](2026-10-22-decision-record-shape.md): Records skill gains the decision shape: Decision first, compact Context, Details, Alternatives and Consequences, and what counts as a decision; baseline 0.8.9.

- [2026-10-22 Standards Completion Checklist](2026-10-22-standards-checklist.md): Checklist aligned with revised guidance, with checks applicable to the work performed; pending baseline 0.8.7.

- [2026-10-22 Consolidated Dependency Policy](2026-10-22-dependency-policy.md): Permission and justification requirements consolidated in implementation guidance; duplicate testing bullets removed; baseline 0.8.7.

- [2026-10-22 Failure Handling And Resource Ownership](2026-10-22-failure-resource-guidance.md): Explicit failure outcomes, error propagation, cleanup, cancellation, safe retries, and required recovery machinery; baseline 0.8.6.

- [2026-10-22 Behavior-Focused Testing Guidance](2026-10-22-testing-guidance.md): Meaningful red failures, state isolation, behavior-focused coverage, and quality checks for existing tests; baseline 0.8.5.

- [2026-10-22 Decision Coverage Before Design And Implementation](2026-10-22-implementation-decision-coverage.md): Conditional complete decision reading, reuse of unchanged records, conflict handling, and checklist coverage; baseline 0.8.4.

- [2026-10-22 Explicit Data Preservation Requirements](2026-10-22-data-preservation-default.md): Finding 2 withdrawn; preservation support requires an explicit project requirement, with resettable data as the default; pending baseline 0.8.3.

- [2026-10-22 Adapter Guidance](2026-10-22-adapter-guidance.md): Approved distinction between substantive adapters, superficial compliance layers, and compatibility scaffolding; baseline 0.8.3.

- [2026-10-22 Full Review: Baseline Standards Skill](2026-10-22-standards-review.md): Adapter and compatibility clarifications; proposed decision, testing, failure-handling, and checklist improvements. Written guidance coverage complete; behavior untested.

- [2026-10-22 Engineering Principle Descriptions](2026-10-22-principle-descriptions.md): Compact definitions for twelve existing principles and four approved additions; baseline 0.8.2.

- [2026-10-21 Review Decision Coverage](2026-10-21-review-decision-coverage.md): Complete decision reading, evidence-backed compliance assessment, and partial verdicts for coverage gaps; baseline 0.8.1.

- [2026-10-19 Review: Special Cases The General Form Can Absorb](2026-10-19-review-special-cases.md): New review item for variants a general mechanism could represent, prompted by Bookish PR #90; baseline 0.8.0.

- [2026-10-16 PR #23 Review](2026-10-16-pr23-review.md): Existing draft target handling needs clarification; draft-state preflight and shared-Python pointer suggested; packaging and six skill validators pass.

- [2026-10-16 Baseline Git Migration And Guidance Review](2026-10-16-baseline-git.md): Standalone Git skill moved to baseline:git in a worktree; Codex/Claude comparison, permission and text-handling findings, recommended revisions approved and implemented.

- [2026-10-16 PR #22 Review](2026-10-16-pr22-review.md): Narrow the conditional-container rule to preserve omission semantics; clarify full-review record identity and debugging audit scope. Metadata, reference paths and whitespace checks pass; runtime behavior remains unverified.

- [2026-10-16 SwiftUI Debugging And Review Modes](2026-10-16.md): SwiftUI skill gains required references, a debugging section and the fixed-outermost-view rule after a toolbar flicker; standards debugging rule; review skill distinguishes diff and full reviews, with full reviews offered after PRs on small or long-unreviewed packages; `.build/tmp/` cleanup rule in `COMMON.md`; baseline 0.6.0, swift 0.11.0.

- [2026-10-15 Review Skill Fixes And Voice Revision](2026-10-15.md): PR #20 review: UI description length exceeds the metadata limit; frontmatter, manifests, paths, template, and whitespace checks pass; runtime and review-quality evaluation remain untested. Follow-up: four over-length UI descriptions fixed; review skill requires repo-wide defect searches and specific checked records; baseline 0.5.1, swift 0.10.2. Voice revision: single `VOICE.md`, explicit but moderated profanity with American slang, "sexy" defined as self-possession.

- [2026-10-14 Review Skill](2026-10-14.md): `baseline:review` skill for broad PR and work reviews, with a required codebase-effect pass and checked-evidence report; refresh default; baseline 0.5.0.

- [2026-10-08 Significant Type Documentation](2026-10-08-type-documentation.md): Concrete responsibilities, state and usage in significant type comments; separate meaning review, shared standards criteria and Swift integration.

- [2026-10-08 Summaries Review, Emphasis Principles And Shared Python](2026-10-08.md): PR #14 review and fixes: historical sources for coming-week planning, complete calendar coverage, baseline 0.4.1; metadata and whitespace checks, validator dependency gap. Calendar authorization runs directly when summaries need access, with an explanation before the command; baseline 0.4.3.

  Emphasis-principles branch delivery: required principles references and local refresh default; baseline 0.4.4, validation waived by Sam. Decision records need a separate confirmation naming the record; baseline 0.4.5.

  Shared Python environment: COMMON.md directs both agents to the venv for agent utilities; security inspection, asdf Python 3.14.8t migration, patched native libraries and hashed pip/PyYAML lock, both validators passing.

  Deferred setup work: investigate dependency ownership and bootstrap order across Homebrew, Mint, asdf, Python and homebrew-xpkg before adding automatic environment setup.

- [2026-10-07 Work Summaries Skill](2026-10-07.md): `baseline:summaries` skill for weekly, daily, project and start-of-day summaries from journals and git history; baseline 0.4.0.

- [2026-10-06 Optimistic Background Validation](2026-10-06.md): Optimistic background validation without prior confirmation, waiting tied to user agreement or an authorized action, final-head merge requirement preserved; swift 0.10.1.

- [2026-10-05 Guidance Compliance](2026-10-05.md): Guidance compliance: COMMON.md import and stricter skill-reading rules in the AGENTS template, required references and checklists in core skills, corrected negation rule, CLAUDE-INTEGRATION.md retired into the README; baseline 0.3.0, swift 0.10.0.

- [2026-10-02 Combined Project Guidance Section](2026-10-02.md): Draft combined Standard Rules format, shared-content fallback, skill scope, and migration checks for baseline:refresh; baseline 0.2.1 version bump and successful runtime cache refresh.

- [2026-09-29 AgentTools Dependency And Approval-Rule Question](2026-09-29.md): `agt` becomes the only dependency (#6), stale skills removed from `AGENTS.md` (#7), rules pass blocked, auto modes instead of approval rules under consideration, SwiftUI workshop guidance added to the swiftui skill, view-debugging helper idea noted.
