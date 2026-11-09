# Hughes Skill Comparison

Compared Kyle Hughes's Universal and Apple Platform plugins at [ea711c1](https://github.com/kylehughes/agent-plugins-for-making-good-software/tree/ea711c19c39c4cdaee5943e5a7d3065cb2ae2426) with the canonical Agents skill sources at `af20cae`. Hughes ships 10 universal skills, 19 Apple skills and eight reviewer definitions. Agents has six baseline and seven Swift plugin skills, plus standalone JavaScript, Python and Ruby guidance. Both catalogues group general and language or platform guidance. Hughes exposes more tasks as callable workflows, including narrow domain jobs and broader compositions with their own handoff and verification rules.

The [skill-by-skill comparison table](2026-11-09-hughes-skill-comparison-table.md) maps all 29 skills to our guidance and proposed changes.

## Candidate Changes

| Disposition | Hughes's approach | Proposed home and scope here |
| --- | --- | --- |
| Revise first | Async test preflight traces observer attachment, event completion, teardown and timeout evidence. | `swift:testing` owns the test recipe, with a pointer from `swift:concurrency`. Replace the NotificationCenter yield and zero-duration cancellation sleep examples with explicit readiness. Distinguish a clock advance, collector detachment, producer shutdown and the bounded window a zero-event assertion actually observes. Correct suite-level `.serialized` in both references, with one authoritative explanation. |
| Add first | Invariant verification selects evidence for a specific claim. Swift modeling enumerates construction, decoding, mutation, persistence and interop paths. | Put the reusable boundary check under `baseline:standards` and Swift examples in `swift:language`'s errors and state reference. Route relevant reviews there. Cover a valid control, a same-boundary counterexample, and a historical fixture where preserving stored data is required. Keep compiler rejection, runtime observations and unverified paths distinct. |
| Revise | Delivery separates implementation proof, behavior-preserving simplification, scoped audit and later ship gates. Hardening bounds repair to the owned change. | Add a conditional pre-PR workflow reference to `baseline:git` and use `baseline:review` for the broad review. Capture scope and the verified behavior before cleanup, reuse checks for the same artifacts, rerun affected checks after fixes, and distinguish ready for review from ready to merge. Keep the project validation entry point authoritative. |
| Add on demand | Accessibility identifiers define an automation contract. Simulator capture and release-size audits define different evidence artifacts. | Put stable semantic, locale-independent, non-sensitive selectors and test-target separation in a conditional `swift:swiftui` UI-testing reference. Add manual or automated run evidence by scenario and platform. Consider simulator capture and App Thinning separately when a project needs repeatable proof. Reusable operational commands belong in AgentTools under decision 0004. |
| Add on demand | App Intents has its own discovery, permissions, entity lookup, execution and scene-routing concerns. | A focused `swift:app-intents` skill is justified when a project needs this surface. Check access at execution and lookup as well as indexing and export. Confirm platform and SDK details from Apple sources for that implementation. |
| Revise selectively | Dedicated API naming, localization, DocC, modal presentation and package-boundary skills. | Prefer targeted references in `swift:language` and `swift:swiftui`. Useful candidates include auditing exported dependencies in `Package.swift` and imports, preserving established localization keys, checking cancel/save and interactive-dismiss paths, and checking DocC examples and public contracts. |
| Leave or defer | Separate symbol ordering and organization rules, UIKit content configurations, App Store business analytics, and extensive App Store release tooling. | Retain our ordering and architecture policies. UIKit guidance is outside the normal SwiftUI-first route, and the business and release workflows need a concrete project use. Keep existing SwiftData, Instruments trace, AgentTools and decision-coverage guidance as locally owned capabilities. |

Universal brainstorming, document design, technical prose, goal compilation and escalation briefs have different jobs from the records skill. For future work, a compact preparation reference could help with consequential design questions or a cold handoff containing the reproduction, decisive evidence and exact question. Goal compilation is a separate candidate for explicit persistent-goal work, with a finite acceptance bar. The existing design and decision confirmation rules apply.

Our [Swift plugin review plan](../../plugins/swift/REVIEW.md) already identifies the serialized-suite correction and the need to reconcile Xcode MCP with AgentTools. The current language toolchain reference recommends Xcode MCP BuildProject while validation requires the AgentTools build and test path for adopting projects. Resolve that precedence with the workflow proposal. The serialized-suite behavior was checked against [Swift Testing's Swift 6.2 release source](https://github.com/swiftlang/swift-testing/blob/swift-6.2-RELEASE/Sources/Testing/Traits/ParallelizationTrait.swift). The readiness and confirmation limits were checked against [Apple's yield documentation](https://developer.apple.com/documentation/swift/task/yield()) and [asynchronous testing guide](https://developer.apple.com/documentation/testing/testing-asynchronous-code). [Paul Hudson's directory](https://github.com/twostraws/Swift-Agent-Skills) was used as an ecosystem index, with no additional skill comparison.

## Delegation And Layout

Hughes uses read-only specialist reviewers in simplification and hardening, with the coordinator running checks, resolving findings and owning edits. The eight roles cover correctness, structure, general simplification, prose, Swift standards, Swift complexity, type modeling and async-test synchronization. Claude registers the Markdown definitions. Hughes documents passing their instructions to a native Codex agent when the named role is unavailable and inline review when delegation is unavailable. See [agent model selection](https://github.com/kylehughes/agent-plugins-for-making-good-software/blob/ea711c19c39c4cdaee5943e5a7d3065cb2ae2426/docs/agent-model-selection.md).

Start with references under the existing skills. If a concern repeatedly fails to route or needs independent invocation, try one narrow skill or one optional read-only reviewer. The reviewer receives the owned scope, relevant decisions, revision or dirty diff and evidence, and returns line-specific findings and explicit coverage gaps. Delegate only when authorized and preserve a single review owner and inline fallback. A larger redesign would retain baseline and Swift plugin packaging, turn broad skills into routing hubs, and give each workflow and reviewer a distinct contract and one canonical owner for each rule.

Use a small positive and near-miss fixture set in both runtimes before splitting further. Candidate cases are a missed one-shot observer notification, an invariant bypass through decoding, a plain naming edit and a prose-only change. Compare selection, caught defects, scope drift, evidence accuracy and cost. Hughes's [composition results](https://github.com/kylehughes/agent-plugins-for-making-good-software/blob/ea711c19c39c4cdaee5943e5a7d3065cb2ae2426/evals/skill-composition/results.md) include failures before the accepted release matrix and apply to its fixtures and tested runtime configurations.

This was a source comparison. No runtime or compiler fixtures were run. No repository-wide redistribution licence was found in the inspected Hughes checkout. The proposals adapt practices and require confirmation before changes to shared guidance. The return point is to select a bounded first slice, with async testing recommended.

## Follow-Up on Swift Ordering and Organization

The proposed change is a small addition to `swift:language`. In the organization reference, make existing declaration order the default whenever moving a member may change a synthesized initializer, enum raw values or `allCases` order, generated code, or a UI sequence. Preserve documentation, attributes and conditional guards with their declarations. Qualify the separate-file conformance convention where synthesis or file-scoped access depends on colocation, and discourage conformances where both the type and protocol belong elsewhere. In the toolchain reference, distinguish SDK or compiler visibility from runtime availability. Keep the current editorial ordering, including the placement of nested types. The linked Swift modeling guide's construction and decoding checks remain a separate candidate above.

Sam narrowed the ordering proposal. Follow our preferred layout when affected callers can be updated and validated together, including when a synthesized initializer's parameter order changes. A change to runtime initialization order can also be acceptable when its effects are understood and within scope. Check for contracts that outlive the source edit, such as independently built clients, persisted raw values, and an established UI sequence. Preserve the contracts that still apply.

Sam approved the ordering and synthesis changes. The [Swift organization reference](../../plugins/swift/skills/language/references/organization.md) now explains when to update callers as part of a reorder and when a synthesized conformance needs to stay with its type. Both Swift plugin manifests are at 0.11.5 on the research branch.

Sam added a reporting requirement. When an external contract is the sole reason for skipping part of a requested cleanup, the agent names the skipped change and its effect on the contract so Sam can decide whether to authorize it.

Sam also approved parameter-order guidance. The [Swift API reference](../../plugins/swift/skills/language/references/language.md#api) now puts the main inputs first, keeps related parameters together, and generally places defaulted options and closures near the end for a readable call site.

## Follow-Up on Async Testing

The [async testing reference](../../plugins/swift/skills/testing/references/async-tests.md) now owns the suite serialization rules and the guidance on readiness, completion, cancellation and awaited cleanup. It shows a confirmation called by the production callback and bounds the zero-event assertion to the awaited operation. The concurrency reference routes here and drops the examples that guessed readiness from a yield or zero-duration sleep. This is part of the pending Swift plugin 0.11.5 update.

The confirmation example compiled in Swift 6 language mode with Swift 6.4.2 and complete concurrency checking. Both parameterized cases passed in Swift Testing.

The two skills now refer to each other by qualified name. The concurrency reference names the async testing reference so it can be found through the owning skill in either runtime.

## Follow-Up on Focused Apple and Swift Topics

The proposed standalone skills are `swift:app-intents` for system actions, entities and queries, and `swift:packages` for manifest products, target dependencies and package boundaries. Write focused guidance from Apple and Swift sources, with SwiftUI examples for app UI. For packages, inspect manifests and imports and make package boundaries explicit. Treat Hughes's suffix taxonomy and coordinator conventions as his project's architecture.

Start accessibility identifiers as a reference in `swift:swiftui`. Cover stable, non-sensitive selectors on the interactive element, exact identifier queries in UI tests and test-only helpers. Add typed identifiers only where they solve a demonstrated problem. Start Apple-specific simplification as a short optional review reference that checks availability, SwiftUI identity and lifecycle, and concurrency when adopting SDK replacements.

Simulator capture is an AgentTools candidate under decision 0004. Start with capture and validation of a chosen simulator and a defined scenario, then integrate with the existing test lane if needed. The installed AgentTools UI command has screenshot and interaction commands. Video capture would be a separate capability. Hughes's two recording scripts are marked all rights reserved, and no repo-wide redistribution licence was found in the inspected revision. Use the workflows as research sources for original guidance and tooling.

## Follow-Up on Local Conventions

Bookish decision 0012 and its Project Layout document are a starting point for package guidance. They describe a thin Xcode host, packages under `Dependencies/`, directional layers and locally developed owned dependencies. Compare those rules with actual project manifests before promoting them. Bookish splits functionality across packages, while Stack groups multiple products and service targets in one package. Keep the choice of package versus target tied to a real boundary.

Stack already demonstrates Commands-aware intents. Its app registers the command centre for App Intents, and `NewItemIntent` awaits `NewItemCommand` through that centre. Use this as a case to inspect when drafting a skill. Keep actions in their owning commands, and account for which intents need foreground presentation or can run without a view.

Pilot accessibility identifiers on one UI test flow. Add selectors to the controls that flow actually needs, using the existing component as the attachment point when it already owns the control. Compare the readability of the SwiftUI before and after the pilot.

The AgentTools branch `feature/simulator-video-roadmap` carries the simulator-video candidate and pinned reference to Hughes. The proposed immediate skill edits are narrower: in `swift:language`, check behavioral equivalence and deployment support when replacing custom code with a project or SDK API. In `swift:swiftui`, preserve interaction and lifecycle when replacing custom views, and distinguish mirrored values from state that represents a separate editing or presentation lifecycle.

## Parked Follow-Up

Sam parked the remaining work. Resume by reviewing these proposed additions with him:

- **`swift:language` API guidance.** When simplifying custom code, look for an existing project or SDK API that does the same job. Check the behaviour callers rely on, such as formatting, errors or cancellation, and retain any fallback the supported deployment targets still need.
- **`swift:swiftui` patterns.** When replacing a custom view with a standard control or container, verify the interactions it owns, including focus, navigation and accessibility where relevant.
- **`swift:swiftui` state guidance.** Derive a mirrored value from its owner when it can be computed cheaply without widening observation. Keep separate state when it represents something distinct, such as an unsaved draft.

The package layout, Commands-aware intents and accessibility pilot remain candidates. The simulator-video proposal belongs to the AgentTools roadmap.
