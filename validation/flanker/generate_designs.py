#!/usr/bin/env python3
"""
Generate FSL design matrices for the ds000102 Flanker task analysis.

Produces:
  - Per-run design.mat files (52 total): HRF-convolved incongruent + congruent
    regressors and their temporal derivatives (4 columns)
  - design.con: contrast file (incongruent > baseline)
  - group_design.mat: group-level design matrix (single column of ones)
  - group_design.con: group-level contrast
  - group_design.grp: covariance split file (single group)

Usage:
  python generate_designs.py \
    --bids-dir /path/to/ds000102 \
    --output-dir /path/to/design_files \
    [--tr 2.0] \
    [--n-vols 146] \
    [--subjects sub-01 sub-02 ...]
"""

import argparse
import numpy as np
import pandas as pd
from pathlib import Path
from scipy.stats import gamma as gamma_dist


# ---------------------------------------------------------------------------
# HRF convolution
# ---------------------------------------------------------------------------

def double_gamma_hrf(t, peak_delay=6.0, undershoot_delay=16.0,
                     peak_disp=1.0, undershoot_disp=1.0, ratio=6.0):
    """Compute the canonical double-gamma HRF at timepoints t (in seconds)."""
    peak = gamma_dist.pdf(t, peak_delay / peak_disp, scale=peak_disp)
    undershoot = gamma_dist.pdf(t, undershoot_delay / undershoot_disp,
                                scale=undershoot_disp)
    hrf = peak - undershoot / ratio
    return hrf / hrf.max()


def make_regressor(onsets, durations, tr, n_vols, oversample=16):
    """
    Build a BOLD regressor by convolving a stimulus boxcar with the HRF.

    Parameters
    ----------
    onsets : array-like
        Event onset times in seconds.
    durations : array-like
        Event durations in seconds.
    tr : float
        Repetition time in seconds.
    n_vols : int
        Number of volumes in the run.
    oversample : int
        Temporal oversampling factor for convolution accuracy.

    Returns
    -------
    regressor : ndarray, shape (n_vols,)
        The HRF-convolved regressor downsampled to TR resolution.
    """
    dt = tr / oversample
    n_timepoints = int(n_vols * tr / dt)

    # Build stimulus boxcar at high temporal resolution
    stimulus = np.zeros(n_timepoints)
    for onset, duration in zip(onsets, durations):
        start_idx = int(round(onset / dt))
        end_idx = start_idx + max(1, int(round(duration / dt)))
        end_idx = min(end_idx, n_timepoints)
        if start_idx < n_timepoints:
            stimulus[start_idx:end_idx] = 1.0

    # Generate HRF kernel (32 seconds)
    hrf_duration = 32.0
    hrf_times = np.arange(0, hrf_duration, dt)
    hrf = double_gamma_hrf(hrf_times)

    # Convolve and trim
    convolved = np.convolve(stimulus, hrf)[:n_timepoints]

    # Downsample to TR resolution
    tr_indices = np.arange(0, n_timepoints, oversample)
    regressor = convolved[tr_indices][:n_vols]

    return regressor


def temporal_derivative(regressor, tr):
    """Compute the temporal derivative of a regressor."""
    return np.gradient(regressor, tr)


# ---------------------------------------------------------------------------
# FSL file format writers
# ---------------------------------------------------------------------------

def write_fsl_matrix(filepath, matrix):
    """Write an FSL-format matrix file (.mat)."""
    matrix = np.atleast_2d(matrix)
    n_rows, n_cols = matrix.shape

    pp_heights = "\t".join(f"{np.max(np.abs(matrix[:, c])):.6e}"
                           for c in range(n_cols))

    lines = [
        f"/NumWaves\t{n_cols}",
        f"/NumPoints\t{n_rows}",
        f"/PPheights\t{pp_heights}",
        "",
        "/Matrix",
    ]
    for row in matrix:
        lines.append("\t".join(f"{v:.6e}" for v in row))

    filepath = Path(filepath)
    filepath.parent.mkdir(parents=True, exist_ok=True)
    filepath.write_text("\n".join(lines) + "\n")


def write_fsl_contrast(filepath, contrast_matrix, n_waves=None):
    """Write an FSL-format contrast file (.con)."""
    contrast_matrix = np.atleast_2d(contrast_matrix)
    n_contrasts, n_cols = contrast_matrix.shape
    if n_waves is not None:
        n_cols = n_waves

    pp_heights = "\t".join(f"{np.max(np.abs(contrast_matrix[:, c])):.6e}"
                           for c in range(contrast_matrix.shape[1]))

    lines = []
    for i in range(n_contrasts):
        lines.append(f"/ContrastName{i+1}\tincongruent_gt_baseline")
    lines.extend([
        f"/NumWaves\t{n_cols}",
        f"/NumContrasts\t{n_contrasts}",
        f"/PPheights\t{pp_heights}",
        "",
        "/Matrix",
    ])
    for row in contrast_matrix:
        padded = np.zeros(n_cols)
        padded[:len(row)] = row
        lines.append("\t".join(f"{v:.6e}" for v in padded))

    filepath = Path(filepath)
    filepath.parent.mkdir(parents=True, exist_ok=True)
    filepath.write_text("\n".join(lines) + "\n")


def write_fsl_grp(filepath, group_assignments):
    """Write an FSL covariance split file (.grp)."""
    n = len(group_assignments)
    lines = [
        f"/NumWaves\t1",
        f"/NumPoints\t{n}",
        "",
        "/Matrix",
    ]
    for g in group_assignments:
        lines.append(str(g))

    filepath = Path(filepath)
    filepath.parent.mkdir(parents=True, exist_ok=True)
    filepath.write_text("\n".join(lines) + "\n")


# ---------------------------------------------------------------------------
# Design matrix construction
# ---------------------------------------------------------------------------

def build_run_design(events_file, tr, n_vols):
    """
    Build the design matrix for a single run.

    Columns (4 total):
      0: incongruent (HRF-convolved, demeaned)
      1: incongruent temporal derivative
      2: congruent (HRF-convolved, demeaned)
      3: congruent temporal derivative

    Parameters
    ----------
    events_file : Path
        BIDS events.tsv file.
    tr : float
        Repetition time in seconds.
    n_vols : int
        Number of volumes.

    Returns
    -------
    design : ndarray, shape (n_vols, 4)
    """
    events = pd.read_csv(events_file, sep="\t")

    incong = events[events["trial_type"].str.startswith("incongruent")]
    cong = events[events["trial_type"].str.startswith("congruent")]

    if len(incong) == 0:
        raise ValueError(f"No incongruent trials found in {events_file}")
    if len(cong) == 0:
        raise ValueError(f"No congruent trials found in {events_file}")

    # Build task regressors
    incong_reg = make_regressor(
        incong["onset"].values, incong["duration"].values, tr, n_vols
    )
    cong_reg = make_regressor(
        cong["onset"].values, cong["duration"].values, tr, n_vols
    )

    # Temporal derivatives
    incong_deriv = temporal_derivative(incong_reg, tr)
    cong_deriv = temporal_derivative(cong_reg, tr)

    # Assemble and demean all columns
    design = np.column_stack([
        incong_reg,
        incong_deriv,
        cong_reg,
        cong_deriv,
    ])
    for c in range(design.shape[1]):
        design[:, c] = design[:, c] - np.mean(design[:, c])

    return design


# ---------------------------------------------------------------------------
# Subject/run discovery
# ---------------------------------------------------------------------------

def discover_runs(bids_dir, subjects=None):
    """
    Discover all subject/run pairs from the BIDS directory.

    Returns list of dicts ordered subjects-first: sub-01_run-1, sub-01_run-2,
    sub-02_run-1, sub-02_run-2, ... (matching resolve_bids.py ordering).
    """
    bids_dir = Path(bids_dir)

    if subjects is None:
        sub_dirs = sorted(bids_dir.glob("sub-*"))
        subjects = [d.name for d in sub_dirs if d.is_dir()]

    runs_info = []
    for sub in subjects:
        for run_id in ["1", "2"]:
            func_dir = bids_dir / sub / "func"
            events_files = sorted(func_dir.glob(
                f"{sub}_task-flanker_run-{run_id}_events.tsv"
            ))
            if not events_files:
                events_files = sorted(func_dir.glob(
                    f"{sub}_task-flanker_events.tsv"
                ))
            if events_files:
                runs_info.append({
                    "subject": sub,
                    "run": run_id,
                    "events_file": events_files[0],
                })
            else:
                print(f"  WARNING: No events.tsv found for {sub} run-{run_id}")

    return runs_info


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Generate FSL design files for ds000102 Flanker analysis"
    )
    parser.add_argument("--bids-dir", required=True,
                        help="Path to BIDS dataset root (ds000102)")
    parser.add_argument("--output-dir", required=True,
                        help="Output directory for design files")
    parser.add_argument("--tr", type=float, default=2.0,
                        help="Repetition time in seconds (default: 2.0)")
    parser.add_argument("--n-vols", type=int, default=146,
                        help="Number of volumes per run (default: 146)")
    parser.add_argument("--subjects", nargs="+", default=None,
                        help="Specific subjects to include (default: all)")
    args = parser.parse_args()

    output_dir = Path(args.output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)

    n_cols = 4

    print(f"BIDS directory: {args.bids_dir}")
    print(f"Output directory: {output_dir}")
    print(f"TR: {args.tr}s, Volumes: {args.n_vols}")
    print(f"Design matrix: {n_cols} columns (no motion regressors)")
    print()

    # 1. Discover runs
    print("Discovering runs...")
    runs_info = discover_runs(args.bids_dir, args.subjects)
    n_runs = len(runs_info)
    print(f"  Found {n_runs} runs")

    # 2. Generate per-run design matrices
    print("\nGenerating per-run design matrices...")
    design_files = []

    for i, run in enumerate(runs_info):
        sub = run["subject"]
        run_id = run["run"]
        label = f"{sub}_run-{run_id}"

        try:
            design = build_run_design(run["events_file"], args.tr, args.n_vols)

            outfile = output_dir / f"{label}_design.mat"
            write_fsl_matrix(outfile, design)
            design_files.append(outfile)

            incong_max = np.max(np.abs(design[:, 0]))
            cong_max = np.max(np.abs(design[:, 2]))
            print(f"  [{i+1:3d}/{n_runs}] {label}: "
                  f"incong_max={incong_max:.3f}, cong_max={cong_max:.3f}")

        except Exception as e:
            print(f"  ERROR generating {label}: {e}")
            return

    # 3. Generate contrast file
    print("\nGenerating contrast file...")
    contrast = np.zeros((1, n_cols))
    contrast[0, 0] = 1.0
    contrast_file = output_dir / "design.con"
    write_fsl_contrast(contrast_file, contrast, n_waves=n_cols)
    print(f"  Written: {contrast_file}")
    print(f"  Contrast: incongruent > baseline = {contrast[0].tolist()}")

    # 4. Generate group-level design files
    print("\nGenerating group-level design files...")

    group_mat = np.ones((n_runs, 1))
    group_mat_file = output_dir / "group_design.mat"
    write_fsl_matrix(group_mat_file, group_mat)
    print(f"  Written: {group_mat_file} ({n_runs} rows × 1 column)")

    group_con = np.ones((1, 1))
    group_con_file = output_dir / "group_design.con"
    write_fsl_contrast(group_con_file, group_con, n_waves=1)
    print(f"  Written: {group_con_file}")

    # Covariance split: single group (all runs treated as independent observations)
    group_assignments = [1] * n_runs

    group_grp_file = output_dir / "group_design.grp"
    write_fsl_grp(group_grp_file, group_assignments)
    print(f"  Written: {group_grp_file} ({n_runs} observations, single group)")

    # 5. Generate job YAML snippet
    print("\nGenerating job YAML snippet...")
    yaml_lines = [
        "# Per-run design matrices",
        "film_gls_design_file:",
    ]
    for df in design_files:
        yaml_lines.append(f"  - {{class: File, path: {df.resolve()}}}")

    yaml_lines.extend([
        "",
        "# Contrast file",
        "film_gls_contrast_file:",
        f"  class: File",
        f"  path: {contrast_file.resolve()}",
        "",
        "# Group design files",
        "flameo_design_file:",
        f"  class: File",
        f"  path: {group_mat_file.resolve()}",
        "flameo_t_con_file:",
        f"  class: File",
        f"  path: {group_con_file.resolve()}",
        "flameo_cov_split_file:",
        f"  class: File",
        f"  path: {group_grp_file.resolve()}",
    ])

    snippet_file = output_dir / "job_snippet.yml"
    snippet_file.write_text("\n".join(yaml_lines) + "\n")
    print(f"  Written: {snippet_file}")

    # Summary
    print(f"\n{'='*60}")
    print(f"SUMMARY")
    print(f"{'='*60}")
    print(f"  Per-run design matrices: {len(design_files)}")
    print(f"  Contrast file:           {contrast_file}")
    print(f"  Group design matrix:     {group_mat_file}")
    print(f"  Group contrast:          {group_con_file}")
    print(f"  Group covariance split:  {group_grp_file}")
    print(f"  Job YAML snippet:        {snippet_file}")
    print(f"\nDesign matrix structure (per run):")
    print(f"  Col 0: Incongruent (HRF-convolved, demeaned)")
    print(f"  Col 1: Incongruent temporal derivative")
    print(f"  Col 2: Congruent (HRF-convolved, demeaned)")
    print(f"  Col 3: Congruent temporal derivative")
    print(f"\nContrast: incongruent > baseline = [1 0 0 0]")
    print(f"\nDone.")


if __name__ == "__main__":
    main()