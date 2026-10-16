# Baseline Git migration and guidance review

Date: 2026-10-16

## Summary

Move the standalone `codex-git` skill into the baseline plugin as `baseline:git`,
and compare its guidance with the GitHub plugin installed in Codex and Anthropic's
published Git commands. Migration is implemented in an isolated worktree;
research-driven content revisions below remain proposals pending confirmation.
Verdict: ready for content revision and validation before deployment.

The skill was imported from the parent repository's pinned submodule revision
`75026a0a7c47c83c831d6a4b3cba5d3ad270e517`. Its procedures are unchanged apart
from the name, heading, UI metadata, icon filenames, and trailing whitespace.
The standalone gitlink and `.gitmodules` entry are removed. Active callers in
`AGENTS.md`, the review skill, and the local refresh instructions use
`baseline:git`. Both baseline manifests prepare version `0.6.0`.
The imported MIT licence is retained in the skill directory.

## Comparison sources

These are inspected sources, not instructions adopted wholesale.

- Codex: installed first-party GitHub plugin cache `openai-curated/github/90718987`,
  skills `github`, `yeet`, `gh-address-comments`, and `gh-fix-ci`, all read in full.
  This is the locally installed snapshot, not a claim that it is the newest
  upstream version or that every Codex environment bundles these skills.
- Claude: Anthropic's official plugin command sources, fetched on the review date:
  [commit](https://github.com/anthropics/claude-plugins-official/blob/main/plugins/commit-commands/commands/commit.md)
  and [commit-push-pr](https://github.com/anthropics/claude-plugins-official/blob/main/plugins/commit-commands/commands/commit-push-pr.md).
  These are optional official commands, not evidence of Claude's complete hidden
  system prompt. No matching installed Claude plugin was found locally.
- [Claude common workflows](https://code.claude.com/docs/en/common-workflows):
  documents conversational PR creation and refinement.
- [OpenAI sandbox protections](https://learn.chatgpt.com/docs/agent-approvals-security):
  default workspace-write protects `.git`, including resolved worktree gitdirs.
- [OpenAI permissions](https://learn.chatgpt.com/docs/permissions): inherited
  workspace protections can be overridden by explicit profile rules.
- [Claude permissions](https://code.claude.com/docs/en/permissions): command
  patterns depend on command spelling; `git -C . push` differs from `git push`.
- GitHub CLI [PR creation](https://cli.github.com/manual/gh_pr_create) and
  [release creation](https://cli.github.com/manual/gh_release_create): support
  `--body-file` and `--notes-file` respectively.

| Topic | Our skill | Codex installed GitHub plugin | Claude official commands | Recommendation |
| --- | --- | --- | --- | --- |
| Tool selection | Optional connector, `gh` for gaps | Connector first; local Git for commits/pushes and `gh` for Actions | Local Git and `gh` | Keep hybrid selection and explicit repository/head/base context |
| Publishing | Draft PR, scoped staging, validation gate | `yeet` covers commit/push/draft PR; uses `codex/` branch and title conventions | Small commit/push/PR commands | Keep our conventions and validation; do not import vendor naming |
| Sandbox writes | Long, repeated escalation advice | Comment handler also assumes elevated network access | Tool allowlists, no Git sandbox diagnosis in these commands | Condense and follow actual session permissions |
| PR text | File-backed body and read-back | `yeet` also prescribes a file with real newlines for CLI fallback | No detailed text-escaping guidance in inspected commands | Keep CLI file path; support structured connector arguments |
| Review threads | Requires thread-aware reads | Distinguishes flat comments from GraphQL review threads | Not covered by inspected commands | Keep |
| CI | Logs first, approval before fixes | Similar Actions-specific workflow with bundled inspection script | Not covered by inspected commands | Keep diagnosis; honor already-authorized fixes |
| Releases | Drafts, title convention, ReleaseTools command | Not covered by inspected skills | Not covered by inspected commands | Keep conventions; fix temporary path and target handling |

## Findings

### Should fix: sandbox guidance is broad and repetitive

`plugins/baseline/skills/git/SKILL.md:15-76` repeats the same premise across five
sections. Line 21 risks treating every index-lock error as a permissions failure;
line 70 encourages escalation merely from uncertainty. The documentation and the
current session's protected paths confirm that `.git` restrictions remain real.
They do not justify assuming every environment requires escalation.

**Proposed replacement for the sandbox, prefix, and read-only sections:**

> Follow the current session's sandbox and approval policy. A command allow rule
> does not grant filesystem access. Under Codex's default workspace-write policy,
> `.git` and resolved worktree Git directories are protected; other permission
> profiles may differ. If the active policy protects Git metadata, use its
> supported approval path for commands that write there. Do not change sandbox
> configuration as part of ordinary Git work.
>
> Diagnose lock errors from the actual message: permission-denied or
> operation-not-permitted failures differ from a lock that already exists.
> Do not delete locks or repeat failing writes as a substitute for diagnosis.
> Run Git mutations serially when they share repository metadata, including
> linked worktrees. Read-only inspection normally needs no escalation.
>
> Prefer the tool's working-directory parameter and plain `git <subcommand>` so
> command-prefix rules match predictably. Use `git -C` when the interface needs
> it; it does not bypass filesystem restrictions. This advice grants no extra
> permission to unrelated commands.

Keep the existing SSH preference as a local convention; do not rewrite existing
remotes automatically. Keep the five conditional GitHub reference routes.

### Should fix: PR workflow can expand scope and create unnecessary writes

`references/pull-requests.md:6` directs the agent to configure branch protection
as part of a PR workflow. That changes repository policy and can affect other
contributors. Lines 12 and 26 require pushing even for a description-only edit.
Lines 14 and 23 create unnecessary confirmation steps when scope or integration
work is already authorized.

**Proposed changes:**

- Preserve PR-only changes to `main`, final-head full validation, and draft-by-default.
- Inspect protection when relevant; configure it only when requested.
- Push the intended head before PR creation or when publishing new commits.
  Editing only title/body does not require a push.
- Honor established scope; stage explicit paths and ask only when ownership of
  changes is ambiguous. Integrate the base when needed for authorized work;
  inspect divergence without making a routine PR depend on an unsolicited pull.
- Use structured body arguments for a suitable connector. For `gh`, keep a
  safely written UTF-8 file with real newlines and `--body-file`.
- Explain that creating the file must also avoid shell interpolation: use file
  tools, a quoted heredoc, or a proper argument API. File flags protect content
  ingestion, not an unsafe command that constructed the file.
- Keep scratchpad / `.build/tmp/` storage and read back the final remote text.

There is no evidence that shell quoting ceased to matter. These are shell
semantics and supported CLI interfaces, not merely a workaround for an agent bug.
A structured connector call can avoid the shell entirely for body text.

### Should fix: release workflow uses a forbidden temporary path and implicit target

`references/draft-releases.md:25` writes to `/tmp`, conflicting with `COMMON.md`
and the PR workflow. It also prescribes `rt changes` for every repository, though
this skill applies across projects. Line 28 omits the actual tag and explicit
creation target from its example; a release from a non-default target can be wrong
if the agent relies on CLI defaults.

**Proposed changes:**

- Use the configured scratchpad or `.build/tmp/` for notes, written safely with
  real newlines, and retain `--notes-file`.
- Use repository release tooling when present (`rt changes` for projects that
  use ReleaseTools); otherwise derive notes from the verified commit range.
- Resolve the release target to a commit and verify the remote target or tag
  matches it. Push only when the authorized workflow needs it.
- Pass the intended tag and explicit target on creation; choose `--verify-tag`
  when using an existing tag. On edits, verify the release's existing target/tag
  instead of assuming that an edit retargets an existing Git tag.
- Keep draft state, `vX.Y.Z` and title conventions, concise summaries, and
  read-back of tag/title/target/draft state. Publishing requires explicit intent.

### Should fix: CI and review guidance should honor existing authorization

`references/github-actions-ci.md:6` requires another approval even when the user
already asked to fix the CI failure. `references/review-comments.md:8` can also
re-ask scope when selected feedback is already explicit.

**Proposed changes:** proceed with a focused, evidence-based fix within authorized
scope; ask for ambiguity, a material tradeoff, or expanded scope. Keep explicit
permission for posting replies, resolving threads, and submitting reviews.
Keep thread-aware review reads and Actions-log retrieval through `gh`.

## Codebase Effect

### Made Obsolete

The standalone Git submodule and runtime name are superseded by the plugin skill.
Historical journal entries retain the old name as history. Existing project files
outside this repository need refresh when deploying the rename.

Checked: `rg -n --hidden 'codex-git|codex-git-skill'` over active tracked guidance,
metadata, and skill sources found callers in `AGENTS.md`, the review skill, and
refresh local-mode instructions, plus the standalone metadata and `.gitmodules`.
All active callers here were updated. Both runtime `codex-git` symlinks currently
point at the retired canonical submodule path; they have not been changed.

### Simplification Now Possible

One plugin version governs the Git guidance. The standalone README, changelog,
logo, and Git metadata are unnecessary in the plugin. The skill's MIT notice and
referenced UI icons are retained. Sandbox content can be reduced as proposed.

Checked: read the standalone `README.md`, `LICENSE`, `SKILL.md`, all five
references, and `agents/openai.yaml`; `git ls-files` enumerated its resources.
The pinned submodule SHA matched its clean source checkout. Copied resources were
read from that SHA, not from an assumed latest checkout.

### Duplication

The two prefix-advice sections and repeated escalation explanation have the same
purpose. Both the PR workflow and entrypoint discuss permissions or writes, but
only the entrypoint should own Git sandbox diagnosis. No executable helper is
needed for this migration.

Checked: `rg -n 'body-file|index.lock|escalat|git -C|/tmp/|Configure GitHub branch|Always push'`
over `AGENTS.md`, `README.md`, `plugins/`, and `runtimes/` found these issues in the
migrated Git entrypoint and references. Other escalation mentions concern Swift
priority and do not duplicate this workflow. Read shared Git and GitHub rule
files; no rule changes are needed for the rename.

### Design Clarity

`baseline:git` owns Git/GitHub mechanics; `baseline:review` owns the broad review
process. Connector availability stays optional. The migration changes skill
selection and packaging, not repository policy or authorization.

Checked: read root and baseline READMEs, both marketplaces, both baseline
manifests, the local refresh instructions, canonical AGENTS template, and the
review skill. The Codex manifest discovers `./skills/`; Claude uses the standard
plugin skills directory. Both manifests prepare `0.6.0`. Read the local
AgentTools checkout at `e9a53b1`, `SkillsPublicTool.swift` (`replaceSymlink`,
`runLink`, and discovery): link creation does not prune retired names.
Installation instructions therefore name the required cleanup explicitly.

## Follow-ups

- After approved content edits, validate and deliver the branch through the
  requested Git lifecycle. No commit, push, PR, merge, or deployment was requested
  in this turn.
- At deployment, inspect the old checkout for local work and retire only owned
  runtime symlinks. Do not run runtime refresh from this review worktree.
- Consider a separate AgentTools change for pruning managed retired links.
  Do not delete arbitrary links or real skill directories.

## Validation and Not Checked

- JSON parsing, skill naming and UI metadata, relative references and assets,
  pinned-copy equivalence, AGENTS template equivalence, active-name search,
  whitespace, and base-checkout isolation are checked for this migration.
- The prescribed Python `quick_validate.py` could not run: PyYAML is absent in
  both system and bundled Python. No dependency was installed for this review.
  Direct frontmatter and metadata checks cover the migrated files; they are not
  reported as the unavailable validator passing.
- No executable code changed; no Swift builds/tests or actionlint run is needed.
- No live PR/release mutations or sandbox-failure probes were performed. The
  permissions conclusions use current vendor docs and the actual session policy.
- Runtime installation, skill sync/link, rules sync, and `agt refresh` were
  deliberately not run: they would affect the canonical checkout or running
  sessions while other work is in progress. Plugin runtime loading is untested.
- No pull/update of the active base checkout or unrelated submodules was attempted.
- Full hidden Git instructions for either product are unavailable; the comparison
  is limited to the named inspected skills, commands, and official documentation.

## Confirmation status

Migration and naming changes are implemented. The four research-driven revision
sets above are pending approval under `baseline:refresh`'s research-phase rules.
The current skill still contains the reviewed procedures. Approve all four sets
or identify any conventions to retain before content editing and deployment.


## Approved revisions implemented

Sam approved all four recommended revision sets on 2026-10-16. Applied them to
`baseline:git` in the existing migration worktree:

- Replaced the repeated sandbox sections with conditional permissions guidance,
  lock-error diagnosis, predictable command prefixes, and serial Git mutations.
- Revised PR handling to honor established scope, avoid description-only pushes,
  reserve protection configuration for explicit requests, and support structured
  connector bodies or safely written CLI body files with remote read-back.
- Revised releases to use repository tooling and workspace note files, verify
  commit ranges and remote tags, pass an explicit creation target, preserve
  draft state, and distinguish release edits from Git tag changes.
- Revised CI and review feedback handling to proceed within existing
  authorization and ask only for ambiguity, expanded scope, or material tradeoffs.

Baseline remains at the prepared `0.6.0` version in both manifests. No deployment,
commit, push, or PR operation was requested. The preceding proposal and pending
status describe the earlier review; this follow-up records approval and completion.

Validation after the approved revisions:

- Read all five revised guidance files in full and checked them against the
  approved proposal, skill-creator guidance, and applicable skill checklists.
- Direct structural checks passed for frontmatter, both plugin versions, UI
  metadata and assets, Markdown links, final newlines, and trailing whitespace.
- Both staged and unstaged `git diff --check` passed. A scoped search found none
  of the removed escalation, automatic protection, mandatory-push, or redundant
  approval wording; temporary-path hits are the intended `.build/tmp/` paths.
- The canonical checkout remains clean on `feature/voice-tweak`; edits remain
  isolated on `feature/baseline-git`.
- The prescribed validator remains unavailable because PyYAML is missing; it was
  not rerun or replaced with an installed dependency. Runtime loading and live
  GitHub mutations remain untested. Builds, unit tests, and actionlint are not
  applicable to these guidance-only edits.

## Python context correction and PR preparation

Sam requested commit, push, and a PR, and questioned the missing PyYAML result.
The earlier validation used the wrong Python interpreters. The shared environment
at `~/.local/share/agents/.venv/bin/python` already provides PyYAML 6.0.3 on
Python 3.14.8t. No package installation is needed.

This worktree was created from the active voice branch's HEAD. Although those
voice commits are now on `main`, that starting tree lacked the shared Python setup
merged in PR #18: the local Python pin, dependency lock, and explicit interpreter
rule in `COMMON.md`. Its `.tool-versions` contained only Node.js; plain `python`
therefore inherited Python 3.14.7t from the home directory, while `python3` on PATH
resolved to the system interpreter. Neither was the shared agent environment.

The skill-creator validators for the Git, review, and refresh skills now pass with
the shared interpreter. Its `pip check` also passes. Earlier missing-PyYAML
statements describe those incorrect invocations, not the availability of the
configured shared environment. Integrate current `main` before the final PR
checks so this branch includes the Python setup without duplicating it.

The unpublished migration commit was rebased cleanly onto current `origin/main`.
All six baseline skills pass `quick_validate.py` with the shared interpreter.
YAML UI metadata/assets, JSON marketplaces/manifests, version agreement,
changed-file links and whitespace, rename references, and AGENTS template checks
pass. The Python pin, lock file, and shared-interpreter rule are preserved.
The final PR diff contains only the migration, approved guidance, and records.
No executable source or Actions workflow changed; runtime installation and live
workflow exercises remain outside this PR preparation.


## Rebase after PR 22 merged

Rebased PR #23 onto `e2bd915` after PR #22 merged. Resolved the two baseline
manifest description conflicts by retaining the Git/GitHub capability description.
PR #22 released baseline `0.6.0`, so both manifests now prepare `0.7.0` for the new
Git skill. Preserved the expanded review modes, standards debugging guidance,
Swift plugin changes, scratch-file cleanup rule, and all journal entries from main.
