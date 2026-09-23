# Review plan

## Agreed direction

- Maintain one Swift plugin in this repository, with separately scoped skills for language, SwiftUI, SwiftData, concurrency, testing, and validation.
- Our content is primary. It is intentionally opinionated. Start each plugin skill from our own version and review outside material (Paul Hudson's skills, Xcode's guidance, books) against it; adopt what improves it and never let it overwrite our positions silently.
- Roll skills in incrementally. `language`, `swiftui`, and `validation` are in the plugin. Concurrency, testing, and SwiftData remain standalone forks of Paul Hudson's skills until reviewed, then move in the same way.
- Attribute derived work in [NOTICE.md](NOTICE.md), with the upstream licence and a note that ours may diverge heavily.
- Migrate Core Data to SwiftData and XCTest to Swift Testing during relevant implementation work. Preserve data, behavior, and test coverage; report migration blockers. Exclude legacy-maintenance guidance.
- Keep validation orchestration separate from test design.
- Keep portable Swift guidance useful without Xcode or Apple frameworks.
- Evaluate Apple guidance individually; distinguish technical requirements from architecture and style preferences.

## Work remaining

1. Record exact revisions and ancestry for the existing Swift skill repositories and Paul Hudson's upstream repositories, plus licenses and local changes.
2. Inventory guidance and referenced resources in `/Applications/Xcode-27.0.0-rc.app`. Record the actual bundle version and build. Search supporting locations under `~/Library` only if missing resources or references point there.
3. Compare substantive rules. Record each source, version/platform/build-setting assumptions, existing local rule, recommendation, rationale, destination skill, and decision status. Classify recommendations as adopt, adapt, retain, reject, or investigate. Review preference changes before implementation.
4. Pilot the testing skill, including the upstream serialized-suite correction and the boundary with validation. Adapt accepted material with attribution, then apply the structure to concurrency and SwiftData. Review language and SwiftUI alongside their original sources.
5. Reconcile shared baseline instructions, project overrides, Xcode MCP usage, and `rt` validation. Decide when targeted checks suffice, when broader checks are required, and how blocked verification is handled.
6. Evaluate realistic requests against an Apple app, a portable Swift package, older deployment targets, mixed concurrency settings, async tests, and a blocked build. Check skill selection, correctness, scope control, tool calls, and honest coverage reporting. Compile technical examples where supported.
7. Installation and discovery are piloted: both runtimes install from this repository and name skills `swift:<skill>`. Repeat the migration (copy, rename, retire the standalone submodule, update references, extend NOTICE.md) for each remaining skill. Keep tools independently released unless a later decision changes that boundary.

## Sources to inventory

- Plugin skills under `skills/` (formerly the `swift-skill`, `swiftui-skill`, and `validation-flow-skill` repositories), and the remaining standalone forks under `../../skills/`: `Swift-Concurrency-Agent-Skill`, `Swift-Testing-Agent-Skill`, and `SwiftData-Agent-Skill`.
- Shared baseline at `../../COMMON.md` and applicable project instructions.
- [Paul Hudson's Swift agent skill directory](https://github.com/twostraws/Swift-Agent-Skills), following original repository links and verifying ancestry.
- Xcode's `Contents/PlugIns/IDEIntelligenceChat.framework/Versions/A/Resources/`: specialist `.idechatprompttemplate` files, their references, and `AdditionalDocumentation`.
- Primary Swift and Apple documentation to verify technical claims and availability.
