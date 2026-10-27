# Commit Identity

Bookish PR #108 reached GitHub with four commits whose committer was `Claude <noreply@anthropic.com>`, although every author was the user and no message carried attribution. A cloud session had rebased them, and a rebase records the configured committer on each commit it rewrites. The Bookish rule "never add yourself to the commit history" was read as a rule about attribution lines, so it did not catch this; local sessions never showed the problem because their git identity is the user's.

The `baseline:git` skill now has a Commit Identity section: commits carry the user's identity as both author and committer; agents check `git var GIT_AUTHOR_IDENT` and `GIT_COMMITTER_IDENT` before committing or rewriting history, set the user's identity when either names the agent (per command when environment variables override configuration), and list author and committer for the branch before pushing, rewriting any agent-identity commit. Shared guidance reaches cloud sessions through the GitHub copy of this repository, so the rule covers them without per-project setup. Baseline 0.8.17.

Not verified: what a cloud environment actually configures, and whether its setup script can set the user's identity. A CI check rejecting agent identities would enforce the rule; it is left for when CI exists.
