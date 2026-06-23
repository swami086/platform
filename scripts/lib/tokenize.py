#!/usr/bin/env python3
"""Tokenize source for n-gram Jaccard similarity (stdlib only)."""
from __future__ import annotations

import argparse
import json
import re
import sys
from itertools import tee
from pathlib import Path

TOKEN_RE = re.compile(r"[a-z0-9_]+")


def tokenize(text: str) -> list[str]:
    return TOKEN_RE.findall(text.lower())


def ngrams(tokens: list[str], n: int) -> set[tuple[str, ...]]:
    if len(tokens) < n:
        return set()
    return {tuple(tokens[i : i + n]) for i in range(len(tokens) - n + 1)}


def jaccard(a: set[tuple[str, ...]], b: set[tuple[str, ...]]) -> float:
    if not a and not b:
        return 0.0
    if not a or not b:
        return 0.0
    inter = len(a & b)
    union = len(a | b)
    return inter / union if union else 0.0


def loc(path: Path) -> int:
    try:
        return sum(1 for _ in path.open("r", encoding="utf-8", errors="ignore"))
    except OSError:
        return 0


def compare_files(source: Path, target: Path, n: int) -> dict:
    if not target.exists():
        return {
            "source": str(source),
            "target": str(target),
            "status": "missing_target",
            "similarity": 0.0,
            "source_loc": loc(source),
            "target_loc": 0,
        }

    src_text = source.read_text(encoding="utf-8", errors="ignore")
    tgt_text = target.read_text(encoding="utf-8", errors="ignore")
    sim = jaccard(ngrams(tokenize(src_text), n), ngrams(tokenize(tgt_text), n))
    return {
        "source": str(source),
        "target": str(target),
        "status": "compared",
        "similarity": round(sim, 4),
        "source_loc": loc(source),
        "target_loc": loc(target),
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Compute token n-gram similarity")
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--target", required=True, type=Path)
    parser.add_argument("--threshold", type=float, default=0.15)
    parser.add_argument("--n", type=int, default=5)
    parser.add_argument("--min-loc", type=int, default=50)
    args = parser.parse_args()

    exts = {".go", ".ts", ".tsx"}
    results: list[dict] = []
    violations: list[dict] = []

    if args.source.is_file():
        pairs = [(args.source, args.target)]
    else:
        pairs = []
        for src in args.source.rglob("*"):
            if src.suffix not in exts or not src.is_file():
                continue
            rel = src.relative_to(args.source)
            pairs.append((src, args.target / rel))

    for src, tgt in pairs:
        row = compare_files(src, tgt, args.n)
        results.append(row)
        if row["status"] == "compared" and row["source_loc"] >= args.min_loc and row["similarity"] > args.threshold:
            violations.append(row)

    report = {
        "threshold": args.threshold,
        "ngram": args.n,
        "min_loc": args.min_loc,
        "pairs": len(results),
        "violations": violations,
        "results": results,
    }
    json.dump(report, sys.stdout, indent=2)
    sys.stdout.write("\n")
    return 1 if violations else 0


if __name__ == "__main__":
    raise SystemExit(main())
