#!/usr/bin/env python3
"""
analyze-swiftui-trace.py — Extract SwiftUI performance data from an Xcode Instruments .trace file.

Usage:
    # Full trace, default top-30 results
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace

    # Restrict to a time window (seconds from trace start)
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace --start 21.63 --end 21.85

    # Show more results
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace --top 50

    # Only show causes or only updates
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace --causes-only
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace --updates-only

    # Filter to views matching a pattern
    ./scripts/analyze-swiftui-trace.py ~/MyApp.trace --filter MyView

Prerequisites:
    - Xcode command-line tools (provides `xctrace`)
    - The trace must have been recorded with the "SwiftUI" Instruments template

What this reports:

  1. INVALIDATION CAUSES — from the swiftui-causes table.
     Each row is an @Observable property change (or environment change, etc.)
     that triggered a view to be marked dirty.  High counts here mean the
     observation graph is too broad (many views depend on the same property).

  2. ACTUAL BODY EVALUATIONS — from the swiftui-updates table.
     Each row is a real View.body call that SwiftUI executed.  The duration
     tells you how expensive each evaluation was.  If the count here is much
     lower than the invalidation count for the same view, SwiftUI is
     successfully skipping redundant evaluations (good).

  Comparing the two tables is the key insight:
    - Causes >> Updates  → invalidations are being sent but skipped (OK, but noisy)
    - Causes ≈ Updates   → every invalidation triggers real work (bad, optimize)
    - High duration/call → the body itself is expensive (consider caching or splitting)
"""

import argparse
import os
import subprocess
import sys
import tempfile
import xml.etree.ElementTree as ET
from collections import Counter


def export_table(trace_path, schema, tmp_dir):
    """Run xctrace export for a given schema and return the output file path."""
    out = os.path.join(tmp_dir, f"{schema}.xml")
    xpath = f'/trace-toc/run/data/table[@schema="{schema}"]'
    result = subprocess.run(
        ["xctrace", "export", "--input", trace_path, "--xpath", xpath],
        capture_output=True, text=False, timeout=300,
    )
    if result.returncode != 0:
        stderr = result.stderr.decode("utf-8", errors="replace")
        print(f"Warning: xctrace export for {schema} failed: {stderr}", file=sys.stderr)
        return None
    with open(out, "wb") as f:
        f.write(result.stdout)
    return out


def shorten(fmt, max_len=100):
    """Shorten a metadata fmt string for display."""
    if not fmt:
        return "(none)"
    s = fmt.split(" AG::")[0].split(" closure")[0]
    # Strip common suffixes
    for noise in [" steel a.square n/a", " blue square.text.square n/a",
                  " steel square.text.square n/a", " steel gear n/a",
                  " steel arrow.right.and.smalltarget n/a",
                  " steel pencil.and.list.clipboard n/a",
                  " steel richtext.page n/a",
                  " steel photo.artframe n/a",
                  " steel t.circle n/a",
                  " steel cursorarrow.rays n/a",
                  " steel square.fill.text.grid.1x2 n/a",
                  " steel square.split.diagonal n/a",
                  " steel arrow.clockwise.square n/a",
                  " steel filemenu.and.selection n/a",
                  " n/a"]:
        if s.endswith(noise):
            s = s[: -len(noise)]
            break
    if len(s) > max_len:
        s = s[: max_len - 1] + "…"
    return s


def resolve(elem, id_cache):
    """Resolve an element that may use ref= to point at a cached element."""
    if "ref" in elem.attrib:
        return id_cache.get(elem.attrib["ref"], elem)
    return elem


def cache_ids(children, id_cache):
    """Cache all elements (and their children) that have an id= attribute."""
    for child in children:
        if "id" in child.attrib:
            id_cache[child.attrib["id"]] = child
        for sub in child:
            if "id" in sub.attrib:
                id_cache[sub.attrib["id"]] = sub


def get_text(elem, id_cache):
    """Get text content of an element, resolving refs."""
    e = resolve(elem, id_cache)
    return e.text if e is not None else None


def get_fmt(elem, id_cache):
    """Get fmt attribute of an element, resolving refs."""
    e = resolve(elem, id_cache)
    return e.get("fmt", "") if e is not None else ""


def parse_causes(xml_path, t_start_ns, t_end_ns, view_filter):
    """Parse the swiftui-causes table and return analysis dicts."""
    id_cache = {}
    by_label = Counter()        # label | value-type -> count
    by_destination = Counter()  # destination view -> count
    by_source_dest = Counter()  # source -> destination -> count
    total = 0

    for _, elem in ET.iterparse(xml_path, events=["end"]):
        if elem.tag != "row":
            continue

        children = list(elem)
        if not children:
            elem.clear()
            continue

        cache_ids(children, id_cache)

        # Timestamp
        ts = None
        for child in children:
            if child.tag == "event-time":
                txt = get_text(child, id_cache)
                if txt:
                    ts = int(txt)
                break
        if ts is None:
            elem.clear()
            continue
        if not (t_start_ns <= ts <= t_end_ns):
            elem.clear()
            continue

        # Source and destination metadata
        src_fmt = dst_fmt = ""
        meta_count = 0
        for child in children:
            if child.tag == "metadata":
                meta_count += 1
                fmt = get_fmt(child, id_cache)
                if meta_count == 1:
                    src_fmt = fmt
                elif meta_count == 2:
                    dst_fmt = fmt

        # Label and value-type (strings after the second metadata)
        strings_after = []
        past_meta = 0
        for child in children:
            if child.tag == "metadata":
                past_meta += 1
            elif past_meta >= 2 and child.tag == "string":
                strings_after.append(get_fmt(child, id_cache))
            elif past_meta >= 2 and child.tag == "sentinel":
                strings_after.append("")

        label = strings_after[0] if len(strings_after) > 0 else ""
        value_type = strings_after[1] if len(strings_after) > 1 else ""

        src_short = shorten(src_fmt)
        dst_short = shorten(dst_fmt)

        if view_filter and view_filter.lower() not in (src_short + dst_short).lower():
            elem.clear()
            continue

        cause_key = f"{label} | {value_type}" if value_type else label
        by_label[cause_key] += 1
        by_destination[dst_short] += 1
        by_source_dest[f"{src_short}  →  {dst_short}"] += 1
        total += 1
        elem.clear()

    return total, by_label, by_destination, by_source_dest


def parse_updates(xml_path, t_start_ns, t_end_ns, view_filter):
    """Parse the swiftui-updates table and return per-view stats."""
    id_cache = {}
    view_counts = Counter()
    view_durations = {}  # view -> [dur_ns, ...]
    total = 0

    for _, elem in ET.iterparse(xml_path, events=["end"]):
        if elem.tag != "row":
            continue

        children = list(elem)
        if not children:
            elem.clear()
            continue

        cache_ids(children, id_cache)

        # Start time
        ts = None
        for child in children:
            if child.tag == "start-time":
                txt = get_text(child, id_cache)
                if txt:
                    ts = int(txt)
                break
        if ts is None:
            elem.clear()
            continue
        if not (t_start_ns <= ts <= t_end_ns):
            elem.clear()
            continue

        # View name (first metadata)
        view_name = ""
        for child in children:
            if child.tag == "metadata":
                view_name = shorten(get_fmt(child, id_cache), max_len=120)
                break

        # Duration
        dur = 0
        for child in children:
            if child.tag == "duration":
                txt = get_text(child, id_cache)
                if txt:
                    dur = int(txt)
                break

        if view_filter and view_filter.lower() not in view_name.lower():
            elem.clear()
            continue

        view_counts[view_name] += 1
        view_durations.setdefault(view_name, []).append(dur)
        total += 1
        elem.clear()

    return total, view_counts, view_durations


def fmt_ms(ns):
    return f"{ns / 1_000_000:.3f}"


def print_section(title, char="="):
    w = max(len(title) + 4, 70)
    print()
    print(char * w)
    print(f"  {title}")
    print(char * w)


def main():
    parser = argparse.ArgumentParser(
        description="Analyze SwiftUI performance from an Xcode Instruments .trace file.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument("trace", help="Path to the .trace bundle")
    parser.add_argument("--start", type=float, default=0,
                        help="Start of time window in seconds (default: 0)")
    parser.add_argument("--end", type=float, default=None,
                        help="End of time window in seconds (default: end of trace)")
    parser.add_argument("--top", type=int, default=30,
                        help="Number of top entries to show (default: 30)")
    parser.add_argument("--filter", type=str, default=None,
                        help="Only show views matching this substring (case-insensitive)")
    parser.add_argument("--causes-only", action="store_true",
                        help="Only show invalidation causes (skip updates)")
    parser.add_argument("--updates-only", action="store_true",
                        help="Only show body updates (skip causes)")
    args = parser.parse_args()

    trace = os.path.expanduser(args.trace)
    if not os.path.exists(trace):
        print(f"Error: {trace} does not exist", file=sys.stderr)
        sys.exit(1)

    t_start_ns = int(args.start * 1_000_000_000)
    t_end_ns = int(args.end * 1_000_000_000) if args.end else 999_999_999_999_999
    top = args.top
    view_filter = args.filter

    window_desc = f"{args.start:.3f}s"
    if args.end:
        window_desc += f" – {args.end:.3f}s"
    else:
        window_desc += " – end"

    print(f"Trace:   {trace}")
    print(f"Window:  {window_desc}")
    if view_filter:
        print(f"Filter:  {view_filter}")

    with tempfile.TemporaryDirectory(prefix="swiftui-trace-") as tmp:
        # ── Causes ──
        if not args.updates_only:
            print("\nExporting swiftui-causes…", end=" ", flush=True)
            causes_xml = export_table(trace, "swiftui-causes", tmp)
            if causes_xml:
                print("parsing…", end=" ", flush=True)
                total, by_label, by_dest, by_src_dest = parse_causes(
                    causes_xml, t_start_ns, t_end_ns, view_filter
                )
                print(f"done ({total} rows).")

                print_section(f"INVALIDATION CAUSES — by label ({total} total)")
                print(f"  {'Count':>6}  Label")
                print(f"  {'─'*6}  {'─'*60}")
                for key, cnt in by_label.most_common(top):
                    print(f"  {cnt:6d}  {key}")

                print_section(f"INVALIDATION CAUSES — by destination view ({total} total)")
                print(f"  {'Count':>6}  Destination View")
                print(f"  {'─'*6}  {'─'*60}")
                for key, cnt in by_dest.most_common(top):
                    print(f"  {cnt:6d}  {key}")

                print_section(f"INVALIDATION CAUSES — source → destination ({total} total)")
                print(f"  {'Count':>6}  Source  →  Destination")
                print(f"  {'─'*6}  {'─'*80}")
                for key, cnt in by_src_dest.most_common(top):
                    print(f"  {cnt:6d}  {key}")
            else:
                print("not available (trace may not include SwiftUI instrument).")

        # ── Updates ──
        if not args.causes_only:
            print("\nExporting swiftui-updates…", end=" ", flush=True)
            updates_xml = export_table(trace, "swiftui-updates", tmp)
            if updates_xml:
                print("parsing…", end=" ", flush=True)
                total, view_counts, view_durs = parse_updates(
                    updates_xml, t_start_ns, t_end_ns, view_filter
                )
                print(f"done ({total} rows).")

                # By count
                print_section(f"BODY EVALUATIONS — by count ({total} total)")
                print(f"  {'Count':>6}  {'Total ms':>10}  {'Avg ms':>8}  View")
                print(f"  {'─'*6}  {'─'*10}  {'─'*8}  {'─'*60}")
                for view, cnt in view_counts.most_common(top):
                    total_ns = sum(view_durs[view])
                    avg_ns = total_ns / cnt
                    print(f"  {cnt:6d}  {fmt_ms(total_ns):>10}  {fmt_ms(avg_ns):>8}  {view}")

                # By total duration
                dur_totals = {v: sum(ds) for v, ds in view_durs.items()}
                print_section(f"BODY EVALUATIONS — by total duration ({total} total)")
                print(f"  {'Total ms':>10}  {'Count':>6}  {'Avg ms':>8}  View")
                print(f"  {'─'*10}  {'─'*6}  {'─'*8}  {'─'*60}")
                for view, total_ns in sorted(dur_totals.items(), key=lambda x: -x[1])[:top]:
                    cnt = view_counts[view]
                    avg_ns = total_ns / cnt
                    print(f"  {fmt_ms(total_ns):>10}  {cnt:6d}  {fmt_ms(avg_ns):>8}  {view}")
            else:
                print("not available (trace may not include SwiftUI instrument).")

    print()


if __name__ == "__main__":
    main()
