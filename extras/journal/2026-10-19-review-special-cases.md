# Review: Special Cases The General Form Can Absorb

## Context

In Bookish PR #90, a record payload was stored as a two-case enum: a typed value conforming to
a payload protocol, or raw JSON for kinds no registry knew. The raw case brought parallel
accessors, per-case equality and encoding, and a raw-members API that leaked into the codec.
Sam spotted that raw payloads could themselves be a type conforming to the protocol, which
collapsed the enum, the accessors and the per-case code. The obstacle had been one
requirement of the general form, a static `recordKind`, which an unknown kind cannot meet;
splitting the protocol so that `kind` is an instance property removed it. Several review
passes had treated that requirement as fixed and missed the simplification.

## Change

- `baseline:review` Process step 4 gains "Special cases the general form can absorb": look
  for variants kept beside a general mechanism that could represent them, with signs to look
  for, the instruction to treat the blocking requirement as open to change, and the payload
  example. Findings are reported under Simplification Now Possible, so the report structure
  and checklist are unchanged.
- The whole-codebase pass ("Review across the whole") looks for the same pattern across
  packages.
- Baseline bumped to 0.8.0.

## Validation

`quick_validate.py` passes for the review skill with the shared `.venv`. Both plugin
manifests agree on 0.8.0. Guidance only; no review was run with the new item.
