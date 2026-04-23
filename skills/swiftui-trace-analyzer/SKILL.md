---
name: swiftui-trace-analyzer
description: Analyze Xcode Instruments SwiftUI .trace files with the bundled analyze-swiftui-trace.py script to diagnose invalidation causes and View.body evaluations.
metadata:
  short-description: Analyze SwiftUI .trace files
---

# SwiftUI Trace Analyzer

## When to use

Use this skill when you need to inspect a SwiftUI Instruments `.trace` file and identify which observations invalidate views, which views are evaluated, and where the hottest update costs are.

## Prerequisites

- Xcode command-line tools (provides `xctrace`).
- The trace must be recorded with the **SwiftUI** Instruments template.

## Quick start

```bash
./scripts/analyze-swiftui-trace.py ~/MyApp.trace
```

## Common workflows

```bash
# Focus on a specific time window (seconds from trace start)
./scripts/analyze-swiftui-trace.py ~/MyApp.trace --start 21.63 --end 21.85

# Filter to views matching a pattern
./scripts/analyze-swiftui-trace.py ~/MyApp.trace --filter SceneTree

# Show more/fewer results
./scripts/analyze-swiftui-trace.py ~/MyApp.trace --top 50

# Only causes or only updates
./scripts/analyze-swiftui-trace.py ~/MyApp.trace --causes-only
./scripts/analyze-swiftui-trace.py ~/MyApp.trace --updates-only
```

## What the script reports

The script prints four tables:

1. Invalidation causes by label — what kind of change triggered the invalidation (`@Observable` property, environment change, layout, etc.).
2. Invalidation causes by destination view — which views are being marked dirty most often.
3. Invalidation causes source → destination — the dependency edge (e.g., `@Observable Foo.(Set<Bar>) → MyRow.body`) and the most actionable data for over-broad observation.
4. Body evaluations by count and duration — actual `View.body` calls with timing.

## How to interpret results

- Causes >> Updates: invalidations are being sent but skipped (usually OK, but noisy).
- Causes ≈ Updates: nearly every invalidation triggers real work (optimize observation or view structure).
- High duration per call: the body itself is expensive (consider caching, splitting, or reducing work).

## Files

- Script: `scripts/analyze-swiftui-trace.py`
