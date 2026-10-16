# Journal

- [2026-10-08 Significant Type Documentation](2026-10-08-type-documentation.md): Concrete responsibilities, state and usage in significant type comments; separate meaning review, shared standards criteria and Swift integration.

- [2026-09-29](2026-09-29.md): `agt` becomes the only dependency (#6), stale skills removed from `AGENTS.md` (#7), rules pass blocked, auto modes instead of approval rules under consideration, SwiftUI workshop guidance added to the swiftui skill, view-debugging helper idea noted.

- [2026-10-02](2026-10-02.md): Draft combined Standard Rules format, shared-content fallback, skill scope, and migration checks for baseline:refresh; baseline 0.2.1 version bump and successful runtime cache refresh.

- [2026-10-05](2026-10-05.md): Guidance compliance: COMMON.md import and stricter skill-reading rules in the AGENTS template, required references and checklists in core skills, corrected negation rule, CLAUDE-INTEGRATION.md retired into the README; baseline 0.3.0, swift 0.10.0.

- [2026-10-06](2026-10-06.md): Optimistic background validation without prior confirmation, waiting tied to user agreement or an authorized action, final-head merge requirement preserved; swift 0.10.1.

- [2026-10-07](2026-10-07.md): `baseline:summaries` skill for weekly, daily, project and start-of-day summaries from journals and git history; baseline 0.4.0.

- [2026-10-08](2026-10-08.md): PR #14 review and fixes: historical sources for coming-week planning, complete calendar coverage, baseline 0.4.1; metadata and whitespace checks, validator dependency gap. Calendar authorization runs directly when summaries need access, with an explanation before the command; baseline 0.4.3.

  Emphasis-principles branch delivery: required principles references and local refresh default; baseline 0.4.4, validation waived by Sam. Decision records need a separate confirmation naming the record; baseline 0.4.5.

  Shared Python environment: COMMON.md directs both agents to the venv for agent utilities; security inspection, asdf Python 3.14.8t migration, patched native libraries and hashed pip/PyYAML lock, both validators passing.

  Deferred setup work: investigate dependency ownership and bootstrap order across Homebrew, Mint, asdf, Python and homebrew-xpkg before adding automatic environment setup.

- [2026-10-14](2026-10-14.md): `baseline:review` skill for broad PR and work reviews, with a required codebase-effect pass and checked-evidence report; refresh default; baseline 0.5.0.

- [2026-10-15](2026-10-15.md): PR #20 review: UI description length exceeds the metadata limit; frontmatter, manifests, paths, template, and whitespace checks pass; runtime and review-quality evaluation remain untested. Follow-up: four over-length UI descriptions fixed; review skill requires repo-wide defect searches and specific checked records; baseline 0.5.1, swift 0.10.2. Voice revision: single `VOICE.md`, explicit but moderated profanity with American slang, "sexy" defined as self-possession.

- [2026-10-16](2026-10-16.md): SwiftUI skill gains required references, a debugging section and the fixed-outermost-view rule after a toolbar flicker; standards debugging rule; review skill distinguishes diff and full reviews, with full reviews offered after PRs on small or long-unreviewed packages; baseline 0.6.0, swift 0.11.0.
