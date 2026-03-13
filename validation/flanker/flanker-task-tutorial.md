# Flanker Task Analysis: End-to-End Tutorial

This tutorial walks through building a complete fMRI analysis pipeline for the Eriksen flanker task using niBuild. By the end, you will have a portable, reproducible workflow bundle that preprocesses BOLD data, registers it to standard (MNI) space, runs a first-level GLM for each subject, and combines results across subjects in a group-level analysis.

## Prerequisites

- A modern web browser (Chrome, Firefox, or Edge)
- Docker **or** Singularity/Apptainer installed on the machine where you will run the workflow
- A BIDS-formatted flanker task dataset (this tutorial uses [ds000102](https://openneuro.org/datasets/ds000102) from OpenNeuro)

### Downloading the Dataset

```bash
# Option A: AWS S3 (no account required)
aws s3 sync --no-sign-request s3://openneuro.org/ds000102 ds000102/

# Option B: DataLad
datalad install https://github.com/OpenNeuroDatasets/ds000102.git
cd ds000102
datalad get sub-*/anat/ sub-*/func/
```

## Pipeline Overview

The workflow chains fifteen FSL tools into a complete preprocessing → registration → statistics pipeline. It includes high-pass temporal filtering (with mean restoration) to remove scanner drift, affine initialization for nonlinear registration, and processes both runs per subject for maximum statistical power. An fslmerge step gathers per-subject-run first-level results into 4D volumes, an fslmaths step derives a group coverage mask from the merged VARCOPEs, and flameo performs group-level mixed-effects analysis:

```
BIDS Dataset
  ├─ t1w ──> BET ──> FLIRT(struct2mni, 12-DOF) ──> FNIRT(affine) ──────────────────────────────────────────┐
  │            └───────────────────────────────────────> FLIRT(func2struct, reference)                        │
  │                                                        ↑                                                  │
  └─ bold ─> MCFLIRT ─┬─ mean_image ─> FLIRT(func2struct)                                                    │
                       │                                                                                       │
                       └─ motion_corrected ─> slicetimer ─> SUSAN ─┬─> fslmaths(Tmean) ──────────────────┐    │
                                                                   └─> fslmaths(bptf) ─> fslmaths(+mean) ┘─> applywarp ─> film_gls ─> fslmerge ─> fslmaths(mask) ─> flameo
                                                                                              │                    ↑                      ↑                  │              ↑
                                                                                      MNI152 ─┤─> FNIRT (ref) design.mat[]          design.mat[]      (varcope mask) design.mat
                                                                                              │                contrast.con                                            contrast.con
                                                                                              └─> applywarp (ref)                                                     cov_split.grp
```

| Step | Tool | Purpose |
|------|------|---------|
| 1 | BET | Skull-strip the T1w structural image |
| 2 | MCFLIRT | Correct head motion in the BOLD time series |
| 3 | slicetimer | Correct inter-slice acquisition timing |
| 4 | SUSAN | Spatially smooth the functional data |
| 5 | fslmaths (bptf) | High-pass temporal filtering to remove scanner drift |
| 6 | fslmaths (Tmean) | Compute temporal mean of smoothed BOLD (before filtering removes it) |
| 7 | fslmaths (add mean) | Add temporal mean back to filtered data (restores positive intensities) |
| 8 | FLIRT (struct→MNI) | 12-DOF affine registration of structural to MNI (initializes FNIRT) |
| 9 | FLIRT (func→struct) | Register functional data to the structural image (linear, 6-DOF) |
| 10 | FNIRT | Register structural image to MNI152 template (nonlinear, with affine init) |
| 11 | applywarp | Apply combined func→struct→MNI transform to functional data |
| 12 | film_gls | Fit the first-level GLM with prewhitening (per-subject-run statistics) |
| 13 | fslmerge | Concatenate per-subject-run COPEs/VARCOPEs into 4D volumes for group analysis |
| 14 | fslmaths (mask) | Derive group coverage mask from merged VARCOPEs (`-bin -Tmin`) |
| 15 | flameo | Group-level mixed-effects analysis across subjects |

---

## Step 1: Load the BIDS Dataset

1. Open niBuild in your browser.
2. In the left-hand tool menu, expand the **I/O** section at the top.
3. Drag the **BIDS** item onto the canvas. A file picker dialog will appear.
4. Select the root directory of your BIDS dataset (the folder containing `dataset_description.json`).

The BIDS modal opens with three areas:

**Subject selection (left panel):**
- Check the subjects you want to process (e.g., `sub-01` through `sub-26`).
- Use "Select all" to include the full cohort.

**Data type selection (top-right chips):**
- Click the **func** chip and the **anat** chip so both are included.

**Output group configuration (bottom-right):**

Create two output groups by clicking the **Add output** button:

| Output label | Datatype | Suffix | Task filter | Run filter |
|--------------|----------|--------|-------------|------------|
| `bold` | func | bold | flanker | all (run-1 and run-2) |
| `t1w` | anat | T1w | — | — |

For the `bold` output, check **Include events** if you want the events TSV files bundled alongside the BOLD data. Make sure **both runs** are selected — ds000102 contains two runs per subject, and including both doubles the within-subject trial count from 24 to 48, substantially boosting statistical power.

Click **Save**. The BIDS node now appears on the canvas with two output ports: `bold` and `t1w`. Scatter is automatically enabled because BIDS outputs are file arrays. The `bold` array will contain 52 files (26 subjects × 2 runs), and the `t1w` array will contain 52 entries (each subject's T1w is duplicated to match the bold array length).

---

## Step 2: Add Input Nodes

In addition to BIDS data, the pipeline needs several external files. Drag **Input** nodes from the I/O section for each:

| Input label | Purpose | File you will provide at runtime |
|-------------|---------|----------------------------------|
| `MNI152` | Standard space template for registration | `$FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz` |
| `design_matrices` | Per-subject-run first-level GLM design matrices (File[]) | Generated from events.tsv (see Step 11) |
| `contrasts` | First-level contrast definitions | Custom `.con` file (see Step 11) |
| `group_design` | Group-level design matrix | Paired repeated-measures design (see Step 15) |
| `group_contrasts` | Group-level contrasts | Mean contrast across subjects (see Step 15) |
| `group_covariance` | Group-level covariance structure | `.grp` file with subject grouping (see Step 15) |

> **Note:** No external brain mask is needed for flameo. The pipeline derives a group coverage mask automatically from the merged VARCOPEs (Step 14), ensuring only voxels with valid data across all subject-runs are included in the group analysis.

> **Note:** The `design_matrices` input is a **File array** — one design matrix per subject-run (52 total) — because ds000102 uses pseudorandom trial ordering and each subject-run has different congruent/incongruent onset times. This input is scattered alongside the BOLD data via dotproduct.

---

## Step 3: Preprocessing — Brain Extraction

### BET (Brain Extraction)

Drag **bet** onto the canvas. Double-click the node to open its parameter modal and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `brain` | Output filename stem |
| `frac` | `0.5` | Fractional intensity threshold (default; lower values include more tissue) |
| `mask` | `true` | Also generate a binary brain mask |

BET operates on the T1w structural image. The skull-stripped brain serves as the reference for functional-to-structural registration (FLIRT), as the input for structural-to-MNI registration (both linear FLIRT and nonlinear FNIRT).

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 1 | BIDS | `t1w` | BET | `input` |

---

## Step 4: Preprocessing — Functional Data

### MCFLIRT (Motion Correction)

Drag **mcflirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_mc` | Output filename stem |
| `mean_vol` | `true` | Register all volumes to the mean (robust for long runs) |
| `save_plots` | `true` | Save motion parameter plots for QC |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 2 | BIDS | `bold` | MCFLIRT | `input` |

### slicetimer (Slice Timing Correction)

Drag **slicetimer** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_st` | Output filename stem |
| `slice_order` | `interleaved` | ds000102 uses interleaved acquisition (select the interleaved variant) |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 3 | MCFLIRT | `motion_corrected` | slicetimer | `input` |

> **Note:** ds000102 uses interleaved slice acquisition. The dataset predates widespread BIDS sidecar metadata adoption, so `SliceTiming` may not appear in the BOLD sidecar JSON. For other datasets, check the `SliceTiming` field in `sub-XX_task-*_bold.json` or consult the acquisition protocol.

### SUSAN (Spatial Smoothing)

Drag **susan** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `brightness_threshold` | `2000` | ~10% of mean image intensity; above noise, below edge contrast |
| `fwhm` | `5` | 5 mm FWHM Gaussian kernel — standard for single-subject fMRI |
| `output` | `bold_smooth` | Output filename stem |

The defaults for `dimension` (3), `use_median` (1), and `n_usans` (0) are appropriate.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 4 | slicetimer | `slice_time_corrected` | SUSAN | `input` |

---

## Step 5: Preprocessing — Temporal Filtering

### fslmaths (High-Pass Filter)

Drag **fslmaths** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `bptf` | `25 -1` | High-pass filter with sigma = 25 volumes; no low-pass (-1) |
| `output` | `bold_filtered_demeaned` | Output filename stem (demeaned — mean is restored in Step 7) |

The `bptf` parameter performs bandpass temporal filtering. The two values are `hp_sigma` and `lp_sigma` in units of volumes (not seconds). The high-pass sigma is calculated as:

```
sigma = cutoff_period / (2 × TR) = 100 / (2 × 2) = 25 volumes
```

This applies a ~100s high-pass filter, which is the FSL default. Setting lp_sigma to `-1` disables low-pass filtering. High-pass filtering removes low-frequency scanner drift that inflates noise variance and reduces t/z-statistics. This is especially important for ds000102's slow event-related design (ITI = 8–14s), where task-related frequencies are relatively close to drift frequencies.

> **Important:** `bptf` removes the temporal mean as part of the high-pass filter, leaving the data zero-centered. This is a problem for downstream tools like `film_gls`, which uses mean intensity to distinguish brain from background — zero-centered data causes ~50% of brain voxels to be randomly masked out. Steps 6 and 7 fix this by computing the temporal mean before filtering and adding it back afterward (the standard FSL FEAT approach).

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5 | SUSAN | `smoothed_image` | fslmaths (bptf) | `input` |

---

## Step 6: Preprocessing — Compute Temporal Mean

### fslmaths (Temporal Mean)

This step computes the temporal mean of the SUSAN output — i.e., the mean intensity at each voxel across all timepoints. This 3D volume captures the baseline signal level that `bptf` removes. It will be added back to the filtered data in Step 7.

Drag **fslmaths** onto the canvas (this is a second, separate fslmaths instance). Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `Tmean` | `true` | Compute mean across the time dimension — produces a 3D volume |
| `output` | `mean_func` | Output filename stem |

Steps 5 (bptf) and 6 (Tmean) both take the SUSAN output as input and can run in parallel.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5b | SUSAN | `smoothed_image` | fslmaths (Tmean) | `input` |

---

## Step 7: Preprocessing — Restore Temporal Mean

### fslmaths (Add Mean Back)

This step adds the temporal mean (from Step 6) back to the high-pass filtered data (from Step 5), restoring positive intensity values while keeping the temporal filtering. This is the standard approach used by FSL's FEAT pipeline.

Drag **fslmaths** onto the canvas (a third fslmaths instance). Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `add_file` | *(wired from Step 6)* | Add the mean_func image to each volume of the filtered data |
| `output` | `bold_filtered` | Output filename stem — this is the final filtered BOLD |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5c | fslmaths (bptf) | `output_image` | fslmaths (add mean) | `input` |
| 5d | fslmaths (Tmean) | `output_image` | fslmaths (add mean) | `add_file` |

---

## Step 8: Registration — Structural to MNI (Linear)

### FLIRT (12-DOF Affine, Structural → MNI)

Drag a **flirt** node onto the canvas. This is a separate FLIRT step from the functional-to-structural registration in Step 9. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `struct2mni_linear` | Output filename stem |
| `output_matrix` | `struct2mni.mat` | Save the 12-DOF affine matrix — used to initialize FNIRT |
| `dof` | `12` | Full affine (translation + rotation + scaling + skew) for inter-subject registration |
| `cost` | `corratio` | Correlation ratio — robust for T1-to-T1 registration |

This step computes a linear approximation of the structural-to-MNI mapping. The resulting affine matrix is passed to FNIRT as initialization, which helps FNIRT converge to a better nonlinear solution — particularly for subjects whose brains differ substantially from the template.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 6 | BET | `brain_extraction` | FLIRT (struct→MNI) | `input` |
| 7 | Input (`MNI152`) | output | FLIRT (struct→MNI) | `reference` |

---

## Step 9: Registration — Functional to Structural

### FLIRT (6-DOF Rigid, Functional → Structural)

Drag another **flirt** node onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `func2struct` | Output filename stem |
| `dof` | `6` | 6-DOF rigid-body (functional-to-structural is intra-subject) |
| `output_matrix` | `func2struct.mat` | Save the transformation matrix — needed by applywarp |
| `cost` | `corratio` | Correlation ratio — robust for EPI-to-T1 registration |

FLIRT takes the mean functional image (from MCFLIRT) as `input` and the skull-stripped T1w (from BET) as `reference`. Using the mean BOLD — rather than the full 4D timeseries — provides a single representative volume with good tissue contrast for registration. MCFLIRT's mean image is unsmoothed and unfiltered, which preserves the tissue boundary detail needed for accurate EPI-to-T1 alignment. The SUSAN-smoothed and bptf-filtered version would have reduced edge contrast, degrading registration quality.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 8 | MCFLIRT | `mean_image` | FLIRT (func→struct) | `input` |
| 9 | BET | `brain_extraction` | FLIRT (func→struct) | `reference` |

---

## Step 10: Registration — Structural to MNI (Nonlinear)

### FNIRT (Nonlinear Registration)

Drag **fnirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `cout` | `struct2mni_warp` | Output warp coefficients filename |
| `iout` | `struct2mni` | Warped output image filename |

FNIRT takes the skull-stripped T1w (from BET) as `input`, the MNI152 template as `reference`, and the 12-DOF affine matrix from Step 8 as `affine` initialization. It produces a nonlinear warp field that maps structural space to MNI space.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 10 | BET | `brain_extraction` | FNIRT | `input` |
| 11 | Input (`MNI152`) | output | FNIRT | `reference` |
| 12 | FLIRT (struct→MNI) | `transformation_matrix` | FNIRT | `affine` |

> FLIRT (struct→MNI) is from Step 8.

---

## Step 11: Transform to Standard Space

### applywarp (Apply Combined Transform)

Drag **applywarp** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_mni` | Output filename — functional data in MNI space |
| `interp` | `spline` | Spline interpolation preserves signal for functional data |

applywarp combines the linear (FLIRT) and nonlinear (FNIRT) transforms in a single resampling step, avoiding double interpolation:

- `input`: Temporally filtered BOLD with mean restored (from fslmaths add mean, Step 7)
- `reference`: MNI152 template
- `warp`: Warp field from FNIRT (Step 10)
- `premat`: Transformation matrix from FLIRT func→struct (Step 9, `func2struct.mat`)

This brings all subjects' functional data into the same standard space, which is required for group-level analysis.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 13 | fslmaths (add mean) | `output_image` | applywarp | `input` |
| 14 | Input (`MNI152`) | output | applywarp | `reference` |
| 15 | FNIRT | `warp_coefficients` | applywarp | `warp` |
| 16 | FLIRT (func→struct) | `transformation_matrix` | applywarp | `premat` |

---

## Step 12: First-Level Statistics

### film_gls (General Linear Model)

Drag **film_gls** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `threshold` | `1000` | Default FSL threshold for brain/background separation; works correctly because the temporal mean was restored in Steps 6–7 |
| `results_dir` | `stats` | Name for the output results directory |
| `smooth_autocorr` | `true` | Smooth autocorrelation estimates for stable prewhitening |

film_gls takes the MNI-space BOLD (from applywarp) as `input`, plus two external files:

1. **Design matrix** (`.mat` file) — encodes the GLM regressors (one per subject-run)
2. **Contrast file** (`.con` file) — defines the contrast of interest (shared across all subject-runs)

film_gls scatters on both `input` and `design_file` using **dotproduct**, so each subject-run receives its own BOLD data paired with its own design matrix. The contrast file is broadcast to all subject-runs.

film_gls produces per-subject-run COPEs (contrast of parameter estimates), VARCOPEs (variance estimates), and t/z-statistic maps.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 17 | applywarp | `warped_image` | film_gls | `input` |
| 18 | Input (`design_matrices`) | output | film_gls | `design_file` |
| 19 | Input (`contrasts`) | output | film_gls | `contrast_file` |

---

## Preparing the First-Level Design

The first-level design matrix encodes the experimental conditions for each subject-run. Because ds000102 uses pseudorandom trial ordering (each subject sees a different sequence of congruent and incongruent trials), **each subject-run needs its own design matrix**.

**Event structure (ds000102):**
- 2 runs per subject (run-1 and run-2)
- 24 trials per run (12 congruent, 12 incongruent) — 48 trials total per subject
- 2-second stimulus duration
- Variable inter-trial interval (8–14 s, mean 12 s)
- TR = 2.0 s, ~146 volumes per run

**Regressors (2 columns):**
1. Congruent trials — onsets and durations convolved with a double-gamma HRF
2. Incongruent trials — onsets and durations convolved with a double-gamma HRF

**Contrast (incongruent > congruent):**

Use a single contrast to keep the pipeline straightforward. With one contrast, film_gls produces exactly one COPE and one VARCOPE per subject-run, which simplifies the downstream merge into 4D volumes.

```
/NumWaves 2
/NumContrasts 1
/Matrix
-1 1
```

This contrast tests for greater activation during incongruent relative to congruent trials — the core cognitive control contrast.

**Creating the design files:**

Option A: Use FSL's `Glm` GUI to design the matrix interactively.

Option B: Use a script to generate subject-specific designs from the BIDS events.tsv files. Generate designs for both runs:

```bash
python generate_designs.py --bids-dir /path/to/ds000102 --run run-1 --output-dir designs
python generate_designs.py --bids-dir /path/to/ds000102 --run run-2 --output-dir designs
```

This produces 52 design files total:
- 26 files for run-1: `sub-01_run-1_design.mat` through `sub-26_run-1_design.mat`
- 26 files for run-2: `sub-01_run-2_design.mat` through `sub-26_run-2_design.mat`

These are provided as a File array to the `design_matrices` input. The array must be ordered to match the `bold` array — all run-1 subjects first, then all run-2 subjects (or whichever order the BIDS node produces).

---

## Step 13: Merge Per-Subject-Run Results

### fslmerge (Concatenate 4D Volumes)

After film_gls completes for all subject-runs, the per-subject-run COPEs and VARCOPEs must be concatenated into single 4D volumes for group analysis. This requires **two fslmerge nodes** — one for COPEs and one for VARCOPEs.

Drag **fslmerge** onto the canvas twice. Double-click each and set:

**fslmerge (COPEs):**

| Parameter | Value | Why |
|-----------|-------|-----|
| `dimension` | `t` | Concatenate along the time/4th dimension |
| `output` | `all_copes` | Output filename for merged COPE volume |

**fslmerge (VARCOPEs):**

| Parameter | Value | Why |
|-----------|-------|-----|
| `dimension` | `t` | Concatenate along the time/4th dimension |
| `output` | `all_varcopes` | Output filename for merged VARCOPE volume |

The fslmerge inputs receive the scattered film_gls outputs. Because film_gls was scattered across subject-runs, its `cope` and `varcope` outputs are nested arrays (`File[][]`). The edge connection flattens these with `$(self.flat())` into a single `File[]` that fslmerge concatenates into a 4D volume.

With a single first-level contrast and two runs per subject, each subject contributes two COPEs and two VARCOPEs, so the merged 4D volumes have 52 volumes (2 per subject × 26 subjects).

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 20 | film_gls | `cope` | fslmerge (COPEs) | `input_files` |
| 21 | film_gls | `varcope` | fslmerge (VARCOPEs) | `input_files` |

---

## Step 14: Generate Group Coverage Mask

### fslmaths (Data-Driven Mask from VARCOPEs)

After registration to MNI space, each subject-run's functional data covers a slightly different region of the brain — voxels outside the original functional field-of-view remain zero after applywarp. With the temporal mean restored (Steps 6–7), most brain voxels (~90–95%) have valid non-zero values per subject-run, but edge voxels still vary across subjects due to differences in head positioning and FOV coverage. FLAMEO requires positive VARCOPE values at every voxel across all observations, so the data-driven mask ensures only voxels with complete coverage are analyzed.

The solution is to derive a **group coverage mask** directly from the data: binarize the merged VARCOPE volume (non-zero → 1, zero → 0), then take the temporal minimum across all 52 volumes. A voxel is 1 in the final mask only if ALL subject-runs had non-zero variance there.

Drag **fslmaths** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `bin` | `true` | Binarize each volume (non-zero varcope → 1, zero → 0) |
| `Tmin` | `true` | Take minimum across the 4th dimension — 1 only where ALL 52 volumes are non-zero |
| `output` | `group_mask` | Output filename for the group coverage mask |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 22 | fslmerge (VARCOPEs) | `merged_image` | fslmaths (mask) | `input` |

> **Why not use the MNI brain mask?** The MNI152 brain mask has ~228,000 voxels, but the ds000102 functional FOV (192×192×160mm) does not cover the full MNI brain extent (182×218×182mm). After applywarp, each subject-run has ~5–15% zero voxels at FOV edges, with the exact pattern depending on head positioning. The data-driven mask restricts analysis to voxels with consistent coverage.

> **Fallback if the strict intersection is empty:** If the `-bin -Tmin` mask has zero non-zero voxels (check with `fslstats group_mask -V`), the functional FOV varies too much across subjects for a strict intersection. Replace the single fslmaths (mask) node with **two** fslmaths nodes to compute a coverage-threshold mask:
>
> **fslmaths node A (coverage fraction):**
>
> | Parameter | Value | Why |
> |-----------|-------|-----|
> | `bin` | `true` | Binarize each volume (non-zero → 1, zero → 0) |
> | `Tmean` | `true` | Compute fraction of volumes with non-zero varcope at each voxel |
> | `thr` | `0.8` | Keep voxels covered by ≥80% of volumes |
> | `output` | `group_coverage` | Intermediate coverage map |
>
> **fslmaths node B (re-binarize):**
>
> | Parameter | Value | Why |
> |-----------|-------|-----|
> | `bin` | `true` | Convert the thresholded fraction map to a binary mask |
> | `output` | `group_mask` | Final binary mask for flameo |
>
> Two nodes are required because the fslmaths CWL defines `bin` as a single boolean — it cannot be applied twice in one step (once before Tmean and once after thr). Wire `fslmerge (VARCOPEs) → node A → node B → flameo mask_file`.
>
> With a relaxed mask, some voxels will have zero varcopes in a minority of observations. FLAMEO handles this by excluding those specific voxels — it reports a warning but still produces valid results at voxels with complete coverage.

---

## Step 15: Group-Level Statistics

### flameo (FMRIB's Local Analysis of Mixed Effects)

Drag **flameo** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `run_mode` | `flame1` | FLAME 1 mixed-effects model — standard for group fMRI |

flameo takes the following inputs:

- `cope_file`: The merged 4D COPE volume from fslmerge (52 subject-run COPEs concatenated)
- `var_cope_file`: The merged 4D VARCOPE volume from fslmerge (52 subject-run VARCOPEs concatenated)
- `design_file`: Group-level design matrix
- `t_con_file`: Group-level contrast file
- `cov_split_file`: Group-level covariance structure (`.grp` file)
- `mask_file`: The data-derived group coverage mask from fslmaths (Step 14)

flameo does **not** scatter — it receives pre-merged 4D volumes and performs group-level inference across all subjects in a single step.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 23 | fslmerge (COPEs) | `merged_image` | flameo | `cope_file` |
| 24 | fslmerge (VARCOPEs) | `merged_image` | flameo | `var_cope_file` |
| 25 | Input (`group_design`) | output | flameo | `design_file` |
| 26 | Input (`group_contrasts`) | output | flameo | `t_con_file` |
| 27 | Input (`group_covariance`) | output | flameo | `cov_split_file` |
| 28 | fslmaths (mask) | `output_image` | flameo | `mask_file` |

Wire the `group_design`, `group_contrasts`, and `group_covariance` Input nodes to flameo. The mask comes from the fslmaths step, not an external input.

**Group-level design for a repeated-measures analysis (52 observations, 26 subjects):**

The design matrix has a single column of 1s — it models the group mean activation. FLAME1 uses the `.grp` file (below) to identify which observations come from the same subject, automatically partitioning variance into within-subject and between-subject components. This is the standard FLAME1 repeated-measures approach.

> **Why not a 26-column subject indicator matrix?** A subject-indicator design (one column per subject) absorbs between-subject variance as nuisance regressors rather than letting the mixed-effects model estimate it properly. FLAME1's strength is its ability to decompose within-subject and between-subject variance using the `.grp` file — a single mean column allows this to work correctly.

```
/NumWaves 1
/NumPoints 52
/Matrix
1    ← sub-01 run-1
1    ← sub-02 run-1
1    ← sub-03 run-1
...  (all 1s through row 26)
1    ← sub-01 run-2
1    ← sub-02 run-2
1    ← sub-03 run-2
...  (all 1s through row 52)
```

**Group contrast:**

Test the mean activation across subjects:

```
/NumWaves 1
/NumContrasts 1
/Matrix
1
```

**Covariance structure (`.grp` file):**

The `.grp` file tells FLAMEO which observations come from the same subject, so it can model within-subject variance separately from between-subject variance:

```
/NumWaves 1
/NumPoints 52
/Matrix
1     ← sub-01 run-1
2     ← sub-02 run-1
3     ← sub-03 run-1
...   (values 4–26 for remaining run-1 subjects)
1     ← sub-01 run-2
2     ← sub-02 run-2
3     ← sub-03 run-2
...   (values 4–26 for remaining run-2 subjects)
```

Each value (1–26) identifies the subject. Rows with the same value are treated as repeated measures from the same subject.

flameo produces group-level t-statistic and z-statistic maps. The z-statistic map is what you threshold and visualize.

---

> **Scatter propagation:** Because the BIDS node has scatter enabled, scatter automatically propagates downstream through all connected nodes from BET through film_gls. Each subject-run is preprocessed and analyzed independently. When using `--cachedir` with cwltool, duplicate T1w processing (BET, FLIRT struct→MNI, FNIRT) is automatically cached — the second run reuses the first run's structural results. At the fslmerge step, the per-subject-run COPEs and VARCOPEs are flattened and concatenated into 4D volumes. The fslmaths mask step (Step 14) then derives a group coverage mask from the merged VARCOPEs, and flameo uses this mask for group analysis.

---

## Step 16: Pin Docker Versions

For reproducibility, pin a specific FSL version rather than using `latest`.

1. Double-click any FSL node (e.g., BET).
2. In the parameter modal, find the **Docker version** dropdown.
3. Select a version such as `6.0.5` or `6.0.4-patched2`.
4. Repeat for each FSL node, or set them all to the same version.

All FSL tools use the `brainlife/fsl` Docker image, so they share the same version tag.

---

## Step 17: Name and Export

1. In the top bar, set the **Output** name to `flanker_pipeline` (or any name you prefer).
2. Click the **Generate Workflow** button in the actions bar.
3. Your browser downloads `flanker_pipeline.crate.zip`.

The ZIP contains:

```
flanker_pipeline.crate.zip/
├── workflows/
│   ├── flanker_pipeline.cwl          # Main CWL workflow
│   └── flanker_pipeline_job.yml      # Job template with your parameter values
├── cwl/
│   └── fsl/
│       ├── bet.cwl
│       ├── mcflirt.cwl
│       ├── slicetimer.cwl
│       ├── susan.cwl
│       ├── fslmaths.cwl
│       ├── flirt.cwl
│       ├── fnirt.cwl
│       ├── applywarp.cwl
│       ├── film_gls.cwl
│       ├── fslmerge.cwl
│       └── flameo.cwl
├── Dockerfile
├── run.sh
├── prefetch_images.sh
├── Singularity.def
├── run_singularity.sh
├── prefetch_images_singularity.sh
├── bids_query.json                   # BIDS selection parameters
├── resolve_bids.py                   # BIDS path resolver script
├── ro-crate-metadata.json            # JSON-LD metadata
└── README.md                         # Execution instructions
```

---

## Step 18: Run the Workflow

Unzip the bundle and edit the job file before running.

### Edit the job template

Open `workflows/flanker_pipeline_job.yml`. Replace placeholder paths with actual paths on your system:

```yaml
# BIDS-resolved inputs (filled by resolve_bids.py or manually)
# 52 entries: 26 subjects × 2 runs (run-1 first, then run-2)
bold:
  # --- run-1 ---
  - class: File
    path: /data/sub-01/func/sub-01_task-flanker_run-1_bold.nii.gz
  - class: File
    path: /data/sub-02/func/sub-02_task-flanker_run-1_bold.nii.gz
  # ... (sub-03 through sub-26 run-1)
  # --- run-2 ---
  - class: File
    path: /data/sub-01/func/sub-01_task-flanker_run-2_bold.nii.gz
  - class: File
    path: /data/sub-02/func/sub-02_task-flanker_run-2_bold.nii.gz
  # ... (sub-03 through sub-26 run-2)

# T1w images: duplicated so each run is paired with its subject's T1w
t1w:
  # --- run-1 (same T1w as run-2) ---
  - class: File
    path: /data/sub-01/anat/sub-01_T1w.nii.gz
  - class: File
    path: /data/sub-02/anat/sub-02_T1w.nii.gz
  # ... (sub-03 through sub-26)
  # --- run-2 (duplicate entries) ---
  - class: File
    path: /data/sub-01/anat/sub-01_T1w.nii.gz
  - class: File
    path: /data/sub-02/anat/sub-02_T1w.nii.gz
  # ... (sub-03 through sub-26)

# MNI template (used by FLIRT, FNIRT, applywarp)
fnirt_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz
flirt_struct2mni_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz
applywarp_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz

# Group coverage mask (derived from data — no external mask needed)
fslmaths_mask_output: group_mask

# Per-subject-run first-level design files (52 total, same order as bold)
film_gls_design_file:
  # --- run-1 ---
  - class: File
    path: /data/additional_inputs/designs/sub-01_run-1_design.mat
  - class: File
    path: /data/additional_inputs/designs/sub-02_run-1_design.mat
  # ... (sub-03 through sub-26 run-1)
  # --- run-2 ---
  - class: File
    path: /data/additional_inputs/designs/sub-01_run-2_design.mat
  - class: File
    path: /data/additional_inputs/designs/sub-02_run-2_design.mat
  # ... (sub-03 through sub-26 run-2)
film_gls_contrast_file:
  class: File
  path: /data/additional_inputs/first_level_design.con

# Group-level design files (52 observations, 26 subjects)
flameo_design_file:
  class: File
  path: /data/additional_inputs/group_design.mat
flameo_t_con_file:
  class: File
  path: /data/additional_inputs/group_design.con
flameo_cov_split_file:
  class: File
  path: /data/additional_inputs/group_cov_split.grp

# Tool parameters (pre-filled from your canvas configuration)
bet_output: brain
bet_frac: 0.5
mcflirt_output: bold_mc
fslmaths_bptf: "25 -1"
fslmaths_output: bold_filtered_demeaned
# fslmaths (Tmean) — compute temporal mean before filtering
fslmaths_2_Tmean: true
fslmaths_2_output: mean_func
# fslmaths (add mean) — restore temporal mean after filtering
fslmaths_3_output: bold_filtered
# add_file is wired from fslmaths_2 output via canvas connection
film_gls_threshold: 1000
flirt_struct2mni_output: struct2mni_linear
flirt_struct2mni_output_matrix: struct2mni.mat
flirt_struct2mni_dof: 12
flirt_struct2mni_cost: corratio
# ... remaining parameters
```

If you used BIDS data, you can run `resolve_bids.py` to auto-populate file paths:

```bash
python resolve_bids.py /path/to/bids/dataset
```

### Option A: Run with Docker

```bash
cd flanker_pipeline

# Optional: pre-pull FSL images
bash prefetch_images.sh

# Build the orchestration container
docker build -t flanker-pipeline .

# Run
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  flanker-pipeline
```

The `-v /var/run/docker.sock:/var/run/docker.sock` mount is required because cwltool inside the container launches per-tool Docker containers (Docker-in-Docker pattern).

### Option B: Run with cwltool directly

```bash
pip install cwltool
cd flanker_pipeline
cwltool --parallel --cachedir cache \
  workflows/flanker_pipeline.cwl workflows/flanker_pipeline_job.yml
```

> **Note:** `--parallel` enables concurrent execution of scattered subject-runs — without it, cwltool processes each sequentially even when scatter is specified. `--cachedir cache` caches completed step outputs so that if the workflow is interrupted, re-running it skips already-finished jobs. With both runs included, caching also avoids redundant BET/FLIRT/FNIRT computation on duplicate T1w inputs.

This requires Docker to be running, as cwltool pulls the `brainlife/fsl` image to execute each step.

### Option C: Run with Singularity (HPC)

```bash
cd flanker_pipeline

# Convert Docker images to SIF
bash prefetch_images_singularity.sh

# Build the orchestration container
singularity build flanker-pipeline.sif Singularity.def

# Run
singularity run \
  --bind /path/to/data:/data \
  --bind /path/to/output:/output \
  flanker-pipeline.sif
```

---

## Expected Outputs

### First-level (film_gls) — per subject-run

film_gls produces a results directory (named `stats` per the configuration above) for each subject-run (52 total):

| File | Description |
|------|-------------|
| `pe1.nii.gz`, `pe2.nii.gz` | Parameter estimate maps (one per regressor) |
| `cope1.nii.gz` | Contrast of parameter estimates (incongruent > congruent) |
| `varcope1.nii.gz` | Variance of the COPE |
| `tstat1.nii.gz` | T-statistic map |
| `zstat1.nii.gz` | Z-statistic map |
| `sigmasquareds.nii.gz` | Residual variance |
| `dof` | Degrees of freedom |

### Merge (fslmerge)

fslmerge produces two 4D volumes:

| File | Description |
|------|-------------|
| `all_copes.nii.gz` | 4D volume containing all 52 subject-run COPE maps (2 runs × 26 subjects) |
| `all_varcopes.nii.gz` | 4D volume containing all 52 subject-run VARCOPE maps |

### Group-level (flameo) — across subjects

flameo produces group-level statistical maps:

| File | Description |
|------|-------------|
| `zstat1.nii.gz` | Group z-statistic map — **this is the key output for the paper figure** |
| `tstat1.nii.gz` | Group t-statistic map |
| `cope1.nii.gz` | Group COPE (mean effect across subjects) |
| `varcope1.nii.gz` | Group variance of COPE |

### Thresholding for the paper figure

The group `zstat1.nii.gz` needs to be thresholded for multiple comparisons. Apply cluster-based correction:

```bash
# Cluster-based thresholding (z > 2.3, cluster p < 0.05)
cluster --in=zstat1.nii.gz --thresh=2.3 --pthresh=0.05 \
  --oindex=cluster_index --olmax=local_maxima.txt \
  --connectivity=26 --mm --cope=cope1.nii.gz

# Or use TFCE via randomise for more robust inference
randomise -i cope1.nii.gz -o group_tfce -d design.mat -t design.con \
  -m mask.nii.gz -T -n 5000
```

### Validation targets

For the flanker task (incongruent > congruent), the group activation map should show significant clusters in:

- **Anterior cingulate cortex (ACC)** — conflict monitoring (~MNI 0, 20, 40)
- **Dorsolateral prefrontal cortex (DLPFC)** — cognitive control (~MNI ±42, 30, 26)
- **Pre-supplementary motor area (pre-SMA)** — response selection (~MNI 0, 6, 52)
- **Inferior frontal junction** — attentional control (~MNI ±44, 6, 30)

With both runs, temporal filtering, and affine-initialized FNIRT, the group analysis should produce peak z-statistics of ~5–6+ with dominant clusters in ACC/pre-SMA. Compare your results against Kelly et al. (2008) Figure 3 and published Flanker meta-analyses.

You can view these maps overlaid on the MNI152 template in FSLeyes, MRIcroGL, or any NIfTI viewer.

---

## Tips

**Multi-subject processing with scatter:**
Because BIDS outputs are arrays (one file per subject-run), scatter automatically parallelizes the entire pipeline across subject-runs. Each subject-run is processed independently through the full preprocessing and first-level chain. At the fslmerge step, the per-subject-run COPEs and VARCOPEs are flattened from nested arrays (`File[][]`) into flat arrays (`File[]`), then concatenated into 4D volumes. The fslmaths mask step computes the intersection of non-zero varcope coverage, and flameo uses this data-driven mask for group analysis.

**Temporal filtering and mean restoration:**
`fslmaths -bptf` removes the temporal mean as part of high-pass filtering, leaving the data zero-centered. If the mean is not restored, downstream tools like `film_gls` that use intensity-based thresholding will randomly mask ~50% of brain voxels. This is a common pitfall; FSL's FEAT handles it automatically by computing `-Tmean` before filtering and `-add`ing it back afterward. The pipeline includes three fslmaths steps (Steps 5–7) to replicate this pattern: compute the temporal mean, apply the high-pass filter, then add the mean back.

**Group coverage mask (why not use the MNI brain mask?):**
The ds000102 functional FOV (192×192×160mm) does not cover the full MNI brain extent (182×218×182mm). After applywarp, each subject-run has ~5–15% zero voxels at FOV edges, with the exact pattern depending on head positioning. FLAMEO excludes any voxel where the VARCOPE is zero or negative in any observation. The `fslmaths -bin -Tmin` step (Step 14) computes the strict intersection of all subjects' coverage. If the strict intersection is empty due to high FOV variability, use the coverage-threshold fallback described in Step 14 (two fslmaths nodes: `-bin -Tmean -thr 0.8` then `-bin`).

**Caching duplicate structural processing:**
When using `--cachedir`, cwltool detects that the same T1w file appears twice in the array (once for each run) and reuses the cached BET, FLIRT struct→MNI, and FNIRT outputs. This means structural processing only runs once per subject, not once per run.

**Per-subject-run design matrices:**
Because ds000102 uses pseudorandom trial ordering, each subject-run's events.tsv has different onset times for congruent and incongruent conditions. The workflow scatters film_gls on both `input` and `design_file` using dotproduct, so the i-th BOLD file is always paired with the i-th design matrix. Ensure the `bold` and `film_gls_design_file` arrays are in the same subject-run order.

**Single first-level contrast:**
Use a single contrast (incongruent > congruent) in the first-level design. With one contrast, each subject-run produces exactly one COPE and one VARCOPE. The fslmerge flattening step (`self.flat()`) then yields a clean array of 52 files — one per subject-run. Multiple contrasts would require separating COPEs by contrast index before merging, which adds complexity.

**Save as a custom workflow:**
To reuse this pipeline in other projects, type a name in the **Name** field (top bar) and click **Save Workflow**. The pipeline appears under **My Workflows** in the left menu and can be dragged onto any future canvas as a single composite node.

**Use the CWL Preview panel:**
Before exporting, open the CWL Preview panel to inspect the generated CWL and job YAML in real time. This helps catch wiring mistakes or missing parameters before you download the bundle.

**Alternative: FEAT for integrated analysis:**
If you prefer FSL's integrated FEAT pipeline (which combines preprocessing and statistics in a single step), drag the **feat** node instead. It requires a pre-configured `.fsf` design file and the BOLD input. This is simpler but less modular than the step-by-step approach shown here.

**Motion QC:**
Before proceeding to statistics, inspect the motion parameter plots from MCFLIRT. Consider excluding subjects with excessive motion (e.g., > 3mm translation or > 3° rotation). In a production pipeline, you would add a QC step here — niBuild includes MRIQC as a single-node option for automated quality assessment.
