#!/usr/bin/env python3
"""Lint du dépôt :
1. chaque chemin `examples/…`, `scripts/…`, `references/…` cité dans un .md ou un .py doit exister
   (les chemins générés par projet — data/, assets/, compositions/ — sont ignorés) ;
2. aucun terme obsolète (`lyceen…`, `hyperframe-slide`, `Mode A/B`, chemins `~/Code/…`) hors
   glossaire, changelog, notes et valeurs par défaut des variables d'environnement.
Sortie 1 s'il y a des écarts.

Usage : python3 scripts/lint-repo.py [--root .]
"""
import argparse
import re
import sys
from pathlib import Path

PATH = re.compile(r"(?<![\w/.$~-])((?:examples|scripts|references)/[A-Za-z0-9_./-]*[A-Za-z0-9_])")
SKIP_PARTS = {".git", "__pycache__", "node_modules"}
LEGACY = re.compile(r"lyceen|hyperframe-slide|\bMode [AB]\b|~/Code/|~/\.agents")
LEGACY_OK_FILES = {"glossaire.md", "CHANGELOG.md", "REFACTOR-NOTES.md", "lint-repo.py"}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root", default=".")
    root = Path(ap.parse_args().root).resolve()
    ap.add_argument("--root", default=".")
    root = Path(ap.parse_args().root).resolve()
    bad = []
    for f in sorted(root.rglob("*")):
        if not f.is_file() or SKIP_PARTS & set(f.parts) or f.suffix not in {".md", ".py"}:
            continue
        for n, line in enumerate(f.read_text(encoding="utf-8").splitlines(), 1):
            if (f.name not in LEGACY_OK_FILES and "os.environ.get" not in line
                    and not (f.name == "SKILL.md" and line.startswith("| `"))
                    and LEGACY.search(line)):
                bad.append(f"{f.relative_to(root)}:{n}: terme obsolète : {LEGACY.search(line).group(0)}")
            for m in PATH.finditer(line):
                ref = m.group(1).rstrip(".")
                if "*" in ref or "<" in ref or ref.endswith("/"):
                    continue
                if not (root / ref).exists():
                    bad.append(f"{f.relative_to(root)}:{n}: chemin absent : {ref}")
    print("\n".join(bad) if bad else "OK : chemins cités présents, aucun terme obsolète")
    return 1 if bad else 0


