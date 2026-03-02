#!/usr/bin/env python3
"""
Prepare OASIS-1 cross-sectional data for VBM Alzheimer's vs. controls analysis.

1. Converts Analyze (.hdr/.img) images to NIfTI (.nii.gz) using nibabel
2. Flattens disc1-12 into a single nifti/ directory
3. Filters subjects by CDR availability (excludes missing CDR and MR2 scans)
4. Generates FSL VEST-format design.mat and design.con files
5. Prints a summary of the cohort

Groups:
  - Controls: CDR = 0
  - Alzheimer's (demented): CDR >= 0.5

Design matrix columns: CONTROL, AD, demeaned_age, demeaned_sex
Contrasts: controls > AD, AD > controls

Usage:
    python prepare_data.py
"""

import csv
import os
import sys
from pathlib import Path

import nibabel as nib

SCRIPT_DIR = Path(__file__).resolve().parent
DATA_DIR = SCRIPT_DIR / "data"
CSV_PATH = DATA_DIR / "oasis_cross-sectional.csv"
NIFTI_DIR = DATA_DIR / "nifti"
OUTPUT_DIR = SCRIPT_DIR / "vbm_alzheimers_crate" / "additional_inputs"


def find_analyze_images(data_dir):
    """Find all SUBJ_111 .hdr files across disc1-12 and return {subject_id: hdr_path}."""
    images = {}
    for disc in sorted(data_dir.glob("disc*")):
        if not disc.is_dir():
            continue
        for hdr in disc.glob("*/PROCESSED/MPRAGE/SUBJ_111/*.hdr"):
            # Extract subject ID from directory name (e.g., OAS1_0001_MR1)
            subject_id = hdr.parents[3].name
            images[subject_id] = hdr
    return images


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


def convert_analyze_to_nifti(hdr_path, output_path):
    """Convert an Analyze .hdr/.img pair to NIfTI .nii.gz."""
    img = nib.load(str(hdr_path))
    nib.save(img, str(output_path))


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
    if not CSV_PATH.exists():
        print(f"Error: CSV not found at {CSV_PATH}", file=sys.stderr)
        sys.exit(1)

    # Step 1: Find all Analyze images on disc
    print("Scanning disc directories for Analyze images...")
    analyze_images = find_analyze_images(DATA_DIR)
    print(f"  Found {len(analyze_images)} subjects across disc directories")

    # Step 2: Read demographics and filter
    print("Reading demographics and filtering subjects...")
    demographics = read_demographics(CSV_PATH)

    # Filter: must have CDR, must be MR1, must have image on disc
    included = []
    excluded_no_cdr = 0
    excluded_mr2 = 0
    excluded_no_image = 0

    for sid, d in demographics.items():
        if "_MR2" in sid:
            excluded_mr2 += 1
            continue
        if d["cdr"] is None:
            excluded_no_cdr += 1
            continue
        if sid not in analyze_images:
            excluded_no_image += 1
            print(f"  Warning: {sid} has CDR but no image found on disc", file=sys.stderr)
            continue
        included.append(sid)

    included.sort()
    print(f"  Included: {len(included)}")
    print(f"  Excluded (no CDR): {excluded_no_cdr}")
    print(f"  Excluded (MR2): {excluded_mr2}")
    print(f"  Excluded (no image): {excluded_no_image}")

    # Step 3: Convert to NIfTI
    print(f"\nConverting Analyze -> NIfTI into {NIFTI_DIR}/")
    NIFTI_DIR.mkdir(parents=True, exist_ok=True)

    for i, sid in enumerate(included):
        hdr_path = analyze_images[sid]
        out_path = NIFTI_DIR / f"{sid}.nii.gz"
        if out_path.exists():
            continue
        convert_analyze_to_nifti(hdr_path, out_path)
        if (i + 1) % 50 == 0 or (i + 1) == len(included):
            print(f"  Converted {i+1}/{len(included)}")

    # Verify all files exist
    missing = [s for s in included if not (NIFTI_DIR / f"{s}.nii.gz").exists()]
    if missing:
        print(f"Error: {len(missing)} NIfTI files missing after conversion", file=sys.stderr)
        sys.exit(1)
    print(f"  All {len(included)} NIfTI files verified")

    # Step 4: Generate design files
    print(f"\nGenerating design files in {OUTPUT_DIR}/")
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
