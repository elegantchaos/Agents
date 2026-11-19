# Collapsed PR And Release Detail

Simon Willison [suggested](https://simonwillison.net/2026/Nov/9/details-summary/) keeping a short readable opener on agent-written PRs and hiding the rest in a `<details>` block. Our git skill already asked for concise descriptions and a human-readable release summary, but nothing kept the long tail out of a reviewer's way.

The pull request reference now asks for one visible paragraph covering what changed, why, and anything the reviewer must act on, with per-file changes, reasoning and full validation results collapsed under a `Details` summary. The article labels the block with the model name; that would break the skill's no-attribution rule, so the label is fixed. GitHub only renders Markdown inside the block when blank lines surround it, which the reference now says. Draft release notes keep their summary visible and collapse a long change list the same way. Baseline plugin 0.8.36.

VO1 closed as declined, as Sam decided on 17 November.
