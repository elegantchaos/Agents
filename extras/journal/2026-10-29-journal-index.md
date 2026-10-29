# Journal Index Normalised

## PR #8 review

- Post-merge diff review of [#8](https://github.com/elegantchaos/Agents/pull/8), which started this journal. Ready; no blocking findings. The repository has no decision log.
- Its index used date-only link titles appended at the end. Later entries used date-and-title links added at the top, so the index read newest first, then oldest first.
- Open suggestions, not applied:
  - the 29 September research summary cites figures (auto mode's 17% false-negative rate, the Rehberger prompt-injection chain) without sources, and [ROADMAP.md](../../ROADMAP.md) points future approval-rule work at it;
  - this repository uses `extras/journal/` while the baseline default is `Extras/Journal/`; the records skill's root-folder rule could say to match case-insensitively, as `baseline:summaries` already does.

## Index normalised

- [index.md](index.md) now lists every entry newest first, ordered by date and then by when each file was first committed.
- The nine date-only links gained titles drawn from their entries' headings. Descriptions and the entries themselves are unchanged.
