# Historical Links

Bookish reorganised its reviews and planning records in [Bookish #140](https://github.com/elegantchaos/Bookish/pull/140). Moving the reviews broke links from about fifty journal entries, and an earlier decision-log review had already left about 220 links in journal entries and archived reviews pointing at decision records that were renumbered, slimmed or removed. The records skill said only that past entries are not rewritten, and its design and decision gates required confirmation for every link edit, so neither case had a rule.

Sam chose to replace each broken link in a historical record with a permalink to the target at the commit where the record first carried the link. The link then opens what the author cited, and the link text keeps its original wording. A prototype script resolved 219 links that way and two by falling back to the last commit that held the target.

## Guidance

The records skill now says:

- New entries use relative links. A relative link shows its target as it is now, so an old entry's links drift as targets are revised, and that is accepted for ordinary revisions.
- A link in a past entry becomes a permalink when the target is moved, renamed or removed, or when a revision removes or reverses what the entry cites. The conversion is made in the change that causes it, and a past entry's link is never repointed at a document that replaced its target.
- Current documentation is the opposite: its links are updated in place to the target's current home.
- Correcting a link's target after a file moves or is renamed needs no confirmation in design documents or decision records, provided the link text and its meaning are unchanged.

Linking to a revision from the start was considered and rejected. An entry usually links to files changed in its own commit, whose hash does not exist when the entry is written, and branch hashes do not survive a rebase or a squash merge. Working the revision out later from the main branch's history avoids both.

Sam noted that drift is itself a repointing in spirit: an unbroken link to a revised target shows different content from what was cited. The wording states that plainly instead of claiming old links stay accurate, and the second trigger covers the cases where it would mislead. That trigger depends on the judgement of whoever revises the target; no tool can detect it.

This shares the 0.8.34 baseline version with the review skill coverage change in the same pull request.

## AgentTools Command

The rule is only cheap if the conversion is mechanical. A candidate AgentTools command, in line with Decision 0004:

- `agt links` reports relative Markdown links whose target is missing, ignoring fenced code, absolute URLs and same-document anchors, decoding percent-encoded paths and handling non-ASCII filenames. Links into a submodule that is not checked out are reported as unverified, not broken.
- `agt links --fix-history` applies only to the journal and reviews folders. For each broken link in a file, it walks the file's history oldest first, following renames, and takes the first commit where the target exists at the path the link then resolved to and the file contains the link. Failing that, it uses the parent of the commit that removed the target and says so. A target that never existed is left and reported.
- The replacement is `https://github.com/<owner>/<repo>/blob/<full sha>/<path>` with any anchor kept and the link text unchanged. The target's path is resolved from the file's location at the commit being tested, since the file may have moved.
- It needs full history and should stop with a clear message in a shallow clone. It should use only commits reachable from the current branch, so the permalinks survive a merge.
- Tests: a target renamed, a target deleted, a linking file that itself moved, a link that never resolved, an anchor, a percent-encoded path and a shallow clone.

The prototype existed only in a cloud session's scratch space and is not preserved; the description above is its algorithm.

## Validation

Documentation only. The shared skill validator was not run: the cloud session has no `~/.local/share/agents/.venv`. The edited skill was read against its own guidance. Installation is due after merge.
