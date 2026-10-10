#!/usr/bin/env python3
"""Filter Verilator coverage to the async_fifo DUT and create inspectable reports.

Run from the project directory after simulation. Only Python's standard library
and the same installation's verilator_coverage executable are required.
"""

from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
from urllib.parse import unquote


SOURCE_ALLOWLIST = (
    "rtl/async_fifo.sv",
    "rtl/fifo_memory.sv",
    "rtl/read_to_write_pointer_sync.sv",
    "rtl/rptr_empty.sv",
    "rtl/wptr_full.sv",
    "dependencies/write_to_read_pointer_sync.sv",
)
STANDARD_TYPES = ("line", "branch", "toggle", "expr")
RECORD = re.compile(r"^C '(.*)' ([0-9]+)$")
FIELD = re.compile(r"\x01([^\x01\x02]+)\x02([^\x01]*)")


def metadata(point_name: str) -> dict[str, str]:
    """Use the first occurrence, matching VlcPoint::keyExtract in v5.052."""
    values: dict[str, str] = {}
    for match in FIELD.finditer(point_name):
        values.setdefault(match.group(1), unquote(match.group(2)))
    return values


def normalized_path(path: Path) -> str:
    return os.path.normcase(str(path.resolve()))


def source_for_record(values: dict[str, str], source_base: Path,
                      sources: dict[str, str]) -> str | None:
    filename = values.get("f", values.get("filename", ""))
    if not filename:
        return None
    # Source paths produced on Linux use '/', but accepting '\\' also permits
    # analysis on Windows of a locally built model without basename matching.
    candidate = Path(filename.replace("\\", "/"))
    if not candidate.is_absolute():
        candidate = source_base / candidate
    return sources.get(normalized_path(candidate))


def canonicalize_filename(point_name: str, source: str) -> str:
    """Keep source paths project-relative so annotations resolve from root."""
    def replace(match: re.Match[str]) -> str:
        if match.group(1) in {"f", "filename"}:
            return "\x01" + match.group(1) + "\x02" + source
        return match.group(0)

    return FIELD.sub(replace, point_name)


def metric_table(records: dict[str, int]) -> dict[str, dict[str, int | float | None]]:
    totals: Counter[str] = Counter()
    hits: Counter[str] = Counter()
    for name, count in records.items():
        values = metadata(name)
        kind = values.get("t", values.get("type", "point")) or "point"
        totals[kind] += 1
        hits[kind] += int(count > 0)
    kinds = list(STANDARD_TYPES) + sorted(set(totals) - set(STANDARD_TYPES))
    return {
        kind: {
            "covered": hits[kind],
            "total": totals[kind],
            "percent": round(100.0 * hits[kind] / totals[kind], 6)
            if totals[kind] else None,
        }
        for kind in kinds
    }


def write_dat(path: Path, records: dict[str, int]) -> None:
    with path.open("w", encoding="utf-8", newline="\n") as stream:
        stream.write("# SystemC::Coverage-3\n")
        for name, count in sorted(records.items()):
            stream.write(f"C '{name}' {count}\n")


def run_tool(command: list[str], project_root: Path, log_path: Path) -> str:
    completed = subprocess.run(command, cwd=project_root, capture_output=True,
                               text=True, encoding="utf-8", errors="replace")
    output = completed.stdout
    if completed.stderr:
        output += "\n[stderr]\n" + completed.stderr
    log_path.write_text(output, encoding="utf-8")
    if completed.returncode:
        raise RuntimeError(
            f"Coverage command failed ({completed.returncode}): "
            f"{' '.join(command)}; see {log_path}"
        )
    return output


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--coverage-tool", default=None,
                        help="Path to verilator_coverage from the simulator installation")
    parser.add_argument("--project-root", type=Path,
                        default=Path(__file__).resolve().parents[1])
    parser.add_argument("--source-base", type=Path, default=None,
                        help="Directory used when compiling relative source paths (default: project root)")
    parser.add_argument("--input", type=Path, default=Path("results/coverage.dat"))
    parser.add_argument("--output-dir", type=Path, default=Path("results"))
    args = parser.parse_args()

    root = args.project_root.resolve()
    source_base = (args.source_base or root).resolve()
    input_path = args.input if args.input.is_absolute() else root / args.input
    output_dir = args.output_dir if args.output_dir.is_absolute() else root / args.output_dir
    output_dir.mkdir(parents=True, exist_ok=True)
    coverage_tool = args.coverage_tool or shutil.which("verilator_coverage")
    if not coverage_tool:
        raise RuntimeError("Cannot find verilator_coverage; supply --coverage-tool")
    tool_path = Path(coverage_tool)
    if not tool_path.is_absolute() and tool_path.is_file():
        coverage_tool = str(tool_path.resolve())

    missing_sources = [source for source in SOURCE_ALLOWLIST if not (root / source).is_file()]
    if missing_sources:
        raise RuntimeError(f"Missing DUT sources: {', '.join(missing_sources)}")
    allowed_paths = {normalized_path(root / source): source for source in SOURCE_ALLOWLIST}
    included: dict[str, int] = defaultdict(int)
    excluded_by_source: Counter[str] = Counter()
    raw_records = 0
    included_raw_records = 0
    with input_path.open(encoding="utf-8") as stream:
        for number, line in enumerate(stream, 1):
            line = line.rstrip("\r\n")
            if not line.startswith("C "):
                if line and not line.startswith("#"):
                    raise ValueError(f"Unexpected coverage data on line {number}")
                continue
            match = RECORD.fullmatch(line)
            if not match:
                raise ValueError(f"Malformed coverage record on line {number}")
            point_name, count_text = match.groups()
            raw_records += 1
            values = metadata(point_name)
            source = source_for_record(values, source_base, allowed_paths)
            if source is None:
                excluded_by_source[values.get("f", values.get("filename", "<no filename>"))] += 1
                continue
            included_raw_records += 1
            included[canonicalize_filename(point_name, source)] += int(count_text)
    if not included:
        raise RuntimeError(
            "No DUT coverage points matched the exact source allowlist. "
            "Check --source-base and that the simulation enabled coverage."
        )

    dut_dat = output_dir / "dut.dat"
    line_branch_dat = output_dir / "dut_line_branch.dat"
    write_dat(dut_dat, included)
    line_branch = {
        name: count for name, count in included.items()
        if metadata(name).get("t", metadata(name).get("type", "")) in {"line", "branch"}
    }
    write_dat(line_branch_dat, line_branch)

    commands = [
        ([coverage_tool, "--version"], "coverage_tool_version.txt"),
        ([coverage_tool, "--report", "summary", str(dut_dat)], "coverage_summary.txt"),
        ([coverage_tool, "--report", "hier", str(dut_dat)], "coverage_hierarchy.txt"),
        ([coverage_tool, "--annotate", str(output_dir / "annotated"), "--annotate-all",
          "--annotate-points", "--annotate-min", "1", str(dut_dat)], "coverage_annotate.log"),
        ([coverage_tool, "--annotate-min", "1", "--write-info", str(output_dir / "dut.info"),
          str(line_branch_dat)], "coverage_lcov.log"),
    ]
    tool_version = ""
    for command, log_name in commands:
        output = run_tool(command, root, output_dir / log_name)
        if log_name == "coverage_tool_version.txt":
            tool_version = output.strip()

    by_source: dict[str, dict[str, int]] = {source: {} for source in SOURCE_ALLOWLIST}
    original_rtl: dict[str, int] = {}
    dependency: dict[str, int] = {}
    for name, count in included.items():
        source = metadata(name).get("f", metadata(name).get("filename", ""))
        by_source[source][name] = count
        if source.startswith("rtl/"):
            original_rtl[name] = count
        else:
            dependency[name] = count

    source_metadata = root / "SOURCE.json"
    provenance = json.loads(source_metadata.read_text(encoding="utf-8-sig")) \
        if source_metadata.is_file() else {}
    source_hashes = {
        source: hashlib.sha256((root / source).read_bytes()).hexdigest()
        for source in SOURCE_ALLOWLIST
    }
    result = {
        "schema_version": 1,
        "created_utc": datetime.now(timezone.utc).isoformat(),
        "scope": "async_fifo DUT and its instantiated submodules only",
        "source_allowlist": list(SOURCE_ALLOWLIST),
        "source_sha256": source_hashes,
        "repository_commit": provenance.get("commit"),
        "supplied_dependency": provenance.get("missing_dependency"),
        "input_records": raw_records,
        "included_input_records": included_raw_records,
        "excluded_input_records": raw_records - included_raw_records,
        "unique_dut_points": len(included),
        "excluded_by_source": dict(sorted(excluded_by_source.items())),
        "metrics": metric_table(included),
        "by_source": {source: metric_table(records) for source, records in by_source.items()},
        "original_repository_rtl_metrics": metric_table(original_rtl),
        "supplied_dependency_metrics": metric_table(dependency),
        "hit_definition": "A unique instrumented point is covered when count > 0; zero-count records remain in the denominator.",
        "denominator_definition": "Verilator instrumented points by type, not all text lines or all possible behaviors.",
        "notes": [
            "Line coverage counts basic-block/line points; native type summaries are authoritative.",
            "Toggle points distinguish 0->1 and 1->0 for each instrumented bit.",
            "With default --coverage-max-width 256, the 32-bit x 65536-word RAM array is not included in toggle coverage.",
            "Testbench, generated PSS runtime, and rtl/load_memory.sv (raw_memory) are excluded.",
            "LCOV is exported from line and branch points only so toggle/expression points cannot become synthetic LCOV branches.",
            "An unavailable type (zero total points) has percent null; code coverage does not establish complete functional verification.",
        ],
        "coverage_tool": {"path": coverage_tool, "version": tool_version},
        "commands": [command for command, _ in commands],
        "artifacts": {
            "dut_data": "dut.dat",
            "line_branch_data": "dut_line_branch.dat",
            "native_summary": "coverage_summary.txt",
            "native_hierarchy": "coverage_hierarchy.txt",
            "annotated_sources": "annotated",
            "lcov": "dut.info",
        },
    }
    (output_dir / "coverage.json").write_text(
        json.dumps(result, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    print("DUT-only coverage (covered / instrumented points):")
    for kind, metric in result["metrics"].items():
        percent = metric["percent"]
        label = f"{percent:.2f}%" if percent is not None else "N/A"
        print(f"  {kind}: {label} ({metric['covered']}/{metric['total']})")
    print(f"Report: {output_dir / 'coverage.json'}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (OSError, ValueError, RuntimeError) as error:
        print(f"Coverage report failed: {error}", file=sys.stderr)
        raise SystemExit(1)
