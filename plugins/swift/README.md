# Swift plugin

Opinionated Swift skills from Elegant Chaos, packaged as one plugin for Claude Code and Codex.

| Skill | Owns |
| --- | --- |
| [swift:language](skills/language/SKILL.md) | Swift language, file organisation, errors and state, localisation, and toolchain assumptions |
| [swift:swiftui](skills/swiftui/SKILL.md) | Views, data flow, navigation, design, accessibility, and UI performance |
| [swift:concurrency](skills/concurrency/SKILL.md) | Actor isolation, structured and unstructured tasks, cancellation, and async streams |
| [swift:testing](skills/testing/SKILL.md) | Swift Testing test design, async tests, and migration from XCTest |
| [swift:swiftdata](skills/swiftdata/SKILL.md) | SwiftData models, queries, predicates, indexing, and CloudKit |
| [swift:validation](skills/validation/SKILL.md) | AgentTools (`agt validate`) formatting, linting, build, and test validation |

## Installation

The marketplace manifests live at the root of this repository: `.claude-plugin/marketplace.json` for Claude Code and `.agents/plugins/marketplace.json` for Codex.

Claude Code loads the plugin in place, so edits take effect in new sessions:

```bash
claude plugin marketplace add ~/.local/share/agents
claude plugin install swift@elegantchaos
```

Codex installs a cached copy. Re-run `codex plugin add` after changes to refresh it:

```bash
codex plugin marketplace add ~/.local/share/agents
codex plugin add swift@elegantchaos
```

Both runtimes name the skills `swift:<skill>`.

`swift:validation` carries a copy of the baseline plugin's `scripts/ensure-agt.sh`, which it uses to get `agt` for `agt validate`. The repository's `scripts/refresh` warns if the copies drift.

## Status

The skills are direct copies of the former standalone skills, renamed to fit the plugin: `swift`, `swift-validation`, and `swiftui` (ours), and `swift-concurrency-pro`, `swift-testing-pro`, and `swiftdata-pro` (our forks of Paul Hudson's skills). Our content is the baseline; outside material is reviewed against it, not merged over it. See [REVIEW.md](REVIEW.md).

## Licence

MIT, © Elegant Chaos. Third-party attribution is in [NOTICE.md](NOTICE.md).
