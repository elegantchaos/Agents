# Behavior-Focused Testing Guidance

Date: 2026-10-22

Applied the approved edits for finding 5 of the [standards review](2026-10-22-standards-review.md). The testing reference now distinguishes an expected behavioral failure from build, fixture, or setup failures; emphasizes observable contracts and real collaborators; and requires isolation from mutable shared state and control of relevant variability.

Behavior-preserving refactoring uses existing tests and adds coverage where meaningful gaps exist. Existing tests are reviewed for implementation mirroring, redundant coverage, and assertions about incidental formatting or documentation; exact output and structure remain protected where they form part of the contract. The same quality criteria govern new tests.

Sam clarified that editing testing guidance does not itself require applying the behavioral testing workflow. No behavioral tests were added or run. Both baseline plugin manifests advance to 0.8.5 under the root README's guidance-versioning rule.

Validation: manual checklist review of the changed guidance and records, with a whitespace and final diff check. No plugin installation or cache refresh was performed; agent behavior remains untested.
