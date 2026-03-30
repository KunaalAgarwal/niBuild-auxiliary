#!/usr/bin/env python3
"""
Generate FSL design matrix (.mat) and contrast (.con) files for the
VBM Alzheimer's vs. controls analysis using OASIS-1.

Scans data/nifti/ for included subjects, reads demographics from
oasis_cross-sectional.csv, and writes VEST-format files into the
crate's additional_inputs/ directory.

Groups:
  - Controls: CDR = 0
  - Alzheimer's (demented): CDR >= 0.5

Design matrix columns: CONTROL, AD, demeaned_age, demeaned_sex
Contrasts: controls > AD, AD > controls

Usage:
    python generate_design_files.py
"""

import csv
import os
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
NIFTI_DIR = SCRIPT_DIR / "data" / "nifti"
CSV_PATH = SCRIPT_DIR / "data" / "oasis_cross-sectional.csv"
OUTPUT_DIR = SCRIPT_DIR / "vbm_analysis" / "additional_inputs"


def get_nifti_subjects(nifti_dir):
    """Scan data/nifti/ for .nii.gz files and return sorted subject IDs."""
    subjects = []
    for f in nifti_dir.glob("*.nii.gz"):
        sid = f.name.replace(".nii.gz", "")
        subjects.append(sid)
    subjects.sort()
    return subjects


def read_demographics(csv_path):
    """Read oasis_cross-sectional.csv into a dict keyed by subject ID."""
    subjects = {}
    with open(csv_path, newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            sid = row["ID"]
            cdr = row["CDR"].strip()
            subjects[sid] = {
                "sex": row["M/F"],
                "age": int(row["Age"]) if row["Age"] else None,
                "cdr": float(cdr) if cdr else None,
            }
    return subjects


def generate_design_mat(subjects_ordered, demographics):
    """Generate a 4-column VEST design matrix.

    Columns: CONTROL, AD, demeaned_age, demeaned_sex
    """
    rows = []
    for sid in subjects_ordered:
        d = demographics[sid]
        control = 1 if d["cdr"] == 0 else 0
        ad = 1 if d["cdr"] >= 0.5 else 0
        age = d["age"]
        sex = 1 if d["sex"] == "M" else 0
        rows.append((control, ad, age, sex))

    n = len(rows)
    mean_age = sum(r[2] for r in rows) / n
    mean_sex = sum(r[3] for r in rows) / n

    lines = [f"/NumWaves 4", f"/NumPoints {n}", "/Matrix"]
    for control, ad, age, sex in rows:
        dm_age = age - mean_age
        dm_sex = sex - mean_sex
        lines.append(f"{control} {ad} {dm_age:.6f} {dm_sex:.6f}")

    return "\n".join(lines) + "\n"


def generate_design_con():
    """Generate a 2-contrast VEST file.

    Contrast 1: controls > AD  (1 -1 0 0)
    Contrast 2: AD > controls  (-1 1 0 0)
    """
    lines = [
        "/NumWaves 4",
        "/NumContrasts 2",
        "/Matrix",
        "1 -1 0 0",
        "-1 1 0 0",
    ]
    return "\n".join(lines) + "\n"


def print_summary(subjects_ordered, demographics):
    """Print cohort summary."""
    controls = [s for s in subjects_ordered if demographics[s]["cdr"] == 0]
    ad = [s for s in subjects_ordered if demographics[s]["cdr"] >= 0.5]

    ctrl_ages = [demographics[s]["age"] for s in controls]
    ad_ages = [demographics[s]["age"] for s in ad]
    all_ages = ctrl_ages + ad_ages

    ctrl_males = sum(1 for s in controls if demographics[s]["sex"] == "M")
    ad_males = sum(1 for s in ad if demographics[s]["sex"] == "M")

    ad_cdr_05 = sum(1 for s in ad if demographics[s]["cdr"] == 0.5)
    ad_cdr_1 = sum(1 for s in ad if demographics[s]["cdr"] == 1.0)
    ad_cdr_2 = sum(1 for s in ad if demographics[s]["cdr"] == 2.0)

    print(f"\nCohort Summary")
    print(f"{'='*50}")
    print(f"Total subjects: {len(subjects_ordered)}")
    print(f"  Controls (CDR=0):    {len(controls)}")
    print(f"  Demented (CDR>=0.5): {len(ad)}")
    print(f"    CDR 0.5: {ad_cdr_05}")
    print(f"    CDR 1.0: {ad_cdr_1}")
    print(f"    CDR 2.0: {ad_cdr_2}")
    print()
    print(f"Age (all):      mean={sum(all_ages)/len(all_ages):.1f}, "
          f"range={min(all_ages)}-{max(all_ages)}")
    print(f"Age (controls): mean={sum(ctrl_ages)/len(ctrl_ages):.1f}, "
          f"range={min(ctrl_ages)}-{max(ctrl_ages)}")
    print(f"Age (demented): mean={sum(ad_ages)/len(ad_ages):.1f}, "
          f"range={min(ad_ages)}-{max(ad_ages)}")
    print()
    print(f"Sex (controls): {ctrl_males}M / {len(controls)-ctrl_males}F")
    print(f"Sex (demented): {ad_males}M / {len(ad)-ad_males}F")


def main():
    # Validate inputs
    if not NIFTI_DIR.exists():
        print(f"Error: NIfTI directory not found at {NIFTI_DIR}", file=sys.stderr)
        sys.exit(1)
    if not CSV_PATH.exists():
        print(f"Error: CSV not found at {CSV_PATH}", file=sys.stderr)
        sys.exit(1)

    # Step 1: Get subject list from NIfTI files
    print("Scanning NIfTI directory for subjects...")
    subjects = get_nifti_subjects(NIFTI_DIR)
    print(f"  Found {len(subjects)} NIfTI files")

    # Step 2: Read demographics
    print("Reading demographics...")
    demographics = read_demographics(CSV_PATH)

    # Step 3: Validate all NIfTI subjects have CDR
    excluded = []
    included = []
    for sid in subjects:
        if sid not in demographics:
            print(f"  Error: {sid} not found in CSV", file=sys.stderr)
            sys.exit(1)
        d = demographics[sid]
        if d["cdr"] is None:
            excluded.append(sid)
            continue
        if d["age"] is None:
            print(f"  Error: {sid} has no age in CSV", file=sys.stderr)
            sys.exit(1)
        included.append(sid)

    if excluded:
        print(f"  Warning: Excluded {len(excluded)} subjects without CDR: {excluded}",
              file=sys.stderr)

    print(f"  Included: {len(included)} subjects")

    # Step 4: Generate design files
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    mat_content = generate_design_mat(included, demographics)
    mat_path = OUTPUT_DIR / "design.mat"
    mat_path.write_text(mat_content)
    print(f"  Wrote {mat_path}")

    con_content = generate_design_con()
    con_path = OUTPUT_DIR / "design.con"
    con_path.write_text(con_content)
    print(f"  Wrote {con_path}")

    # Step 5: Print summary
    print_summary(included, demographics)


if __name__ == "__main__":
    main()
