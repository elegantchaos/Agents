# Swift plugin

Opinionated Swift skills from Elegant Chaos, packaged as one plugin for Claude Code and Codex.

| Skill | Owns |
| --- | --- |
| [swift:language](skills/language/SKILL.md) | Swift language, file organisation, errors and state, localisation, and toolchain assumptions |
| [swift:swiftui](skills/swiftui/SKILL.md) | Views, data flow, navigation, design, accessibility, and UI performance |
| [swift:validation](skills/validation/SKILL.md) | ReleaseTools (`rt validate`) formatting, linting, build, and test validation |

## Installation

The marketplace manifests live at the root of this repository: `.claude-plugin/marketplace.json` for Claude Code and `.agents/plugins/marketplace.json` for Codex.

Claude Code loads the plugin in place, so edits take effect in new sessions:

```bash
claude plugin marketplace add ~/.local/share/agents
claude plugin install swift@elegantchaos
```

Codex installs a cached copy, so upgrade after changes:

```bash
codex plugin marketplace add ~/.local/share/agents
codex plugin add swift@elegantchaos
codex plugin marketplace upgrade elegantchaos
```

Both runtimes name the skills `swift:<skill>`.

## Status

The skills are direct copies of the former standalone `swift`, `swift-validation`, and `swiftui` skills, renamed to fit the plugin. Our content is the baseline; outside material is reviewed against it, not merged over it. See [REVIEW.md](REVIEW.md).

Concurrency, Swift Testing, and SwiftData guidance still comes from the standalone `swift-concurrency-pro`, `swift-testing-pro`, and `swiftdata-pro` skills, which are forks of Paul Hudson's work. They are planned to move into this plugin once reviewed.

## Licence

MIT, © Elegant Chaos. Third-party attribution is in [NOTICE.md](NOTICE.md).
