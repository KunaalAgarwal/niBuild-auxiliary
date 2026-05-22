# fMRI Flanker Task Analysis Tutorial

This tutorial walks through building a **complete task-fMRI analysis** in niBuild — from a raw BIDS dataset, through preprocessing and a first-level GLM, to a group-level activation map. By the end you will have a portable, reproducible workflow bundle that takes BOLD and T1w data and produces a group z-statistic map for the flanker task.

The pipeline reproduces a classic task-fMRI analysis on the [ds000102](https://openneuro.org/datasets/ds000102) flanker dataset: **26 participants, 2 runs each (52 subject-runs)**. Preprocessing and the first-level GLM run independently on every subject-run; the group stage pools all 52 runs into a single mixed-effects analysis.

## Prerequisites

- A modern web browser (Chrome, Firefox, or Edge)
- Docker **or** Singularity/Apptainer installed on the machine where you will run the workflow
- A BIDS-formatted flanker task dataset (this tutorial uses [ds000102](https://openneuro.org/datasets/ds000102) from OpenNeuro)
- Python 3 with `numpy`, `pandas`, and `scipy` — used by the `generate_designs.py` helper script that builds the GLM design files (see Step 11)

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

The workflow chains **14 FSL steps** into three phases:

| Step | Tool | Purpose |
|------|------|---------|
| 1 | BET | Skull-strip the T1w structural image |
| 2 | MCFLIRT | Correct head motion in the BOLD time series |
| 3 | slicetimer | Correct inter-slice acquisition timing |
| 4 | SUSAN | Spatially smooth the functional data |
| 5 | fslmaths (Tmean) | Compute temporal mean of smoothed BOLD (before filtering removes it) |
| 6 | fslmaths (bptf + add mean) | High-pass filter and restore temporal mean |
| 7 | FLIRT (struct→MNI) | 12-DOF affine registration of structural to MNI brain template (initializes FNIRT) |
| 8 | FLIRT (func→struct) | Register functional data to the structural image (linear, 6-DOF) |
| 9 | FNIRT | Register structural image to MNI152 template (nonlinear, with affine init) |
| 10 | applywarp | Apply combined func→struct→MNI transform to functional data |
| 11 | film_gls | First-level GLM — fit a per-run design matrix, producing per-run COPE/VARCOPE/z-stat |
| 12 | fslmerge (×2) | Concatenate the 52 per-run COPE and VARCOPE volumes into two 4D files |
| 13 | FLAMEO | Group-level mixed-effects analysis across all 52 runs |

- **Steps 1–10 — preprocessing** (per subject-run): motion/slice-timing correction, smoothing, filtering, and registration to MNI152 2 mm space. This is the same endpoint as fMRIPrep.
- **Step 11 — first-level GLM** (per subject-run): fits the flanker design matrix to each preprocessed run with FILM prewhitening.
- **Steps 12–13 — group level** (once): merges the per-run contrast estimates and runs a group mixed-effects analysis.

Because the BIDS node emits file arrays, scatter propagates automatically through Steps 1–11 — every subject-run is processed independently and in parallel. The two `fslmerge` nodes (Step 12) are the *gather* point where the 52 per-run results converge into the group analysis.

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

For the `bold` output, check **Include events** to bundle the events TSV files alongside the BOLD data; Step 11 uses these events files to build the first-level GLM design matrices. Make sure **both runs** are selected as ds000102 contains two runs per subject, and including both doubles the within-subject trial count from 24 to 48, substantially boosting statistical power.

Click **Save**. The BIDS node now appears on the canvas with two output ports: `bold` and `t1w`. Scatter is automatically enabled because BIDS outputs are file arrays. The `bold` array will contain 52 files (26 subjects × 2 runs), and the `t1w` array will contain 52 entries (each subject's T1w is duplicated to match the bold array length).

> **Why T1w must be duplicated to match the BOLD array length:**
> Several downstream steps use `dotproduct` scatter to pair functional and structural data element-by-element. For example, FLIRT (func→struct) scatters over both `mcflirt/mean_image` (52 functional files) and `bet/brain_extraction` (from the T1w array) simultaneously meaning the i-th functional file is paired with the i-th structural file. Similarly, applywarp scatters over functional data, FNIRT warp coefficients, and FLIRT transformation matrices together. CWL's `dotproduct` requires all scattered arrays to have the same length. Since there are 52 BOLD files (26 subjects × 2 runs) but only 26 unique T1w images, each T1w must appear twice so that the structural array (52) matches the functional array (52). When using `--cachedir`, cwltool detects duplicate T1w inputs and reuses cached BET/FLIRT/FNIRT outputs, so structural processing still only runs once per subject.

> **Array ordering — keep it subjects-first:** Both arrays are ordered subject-by-subject with runs interleaved: `sub-01` run-1, `sub-01` run-2, `sub-02` run-1, `sub-02` run-2, … This ordering matters in Step 11, where the per-run GLM design matrices must line up element-by-element with the `bold` array.

---

## Step 2: Add Input Nodes

In addition to BIDS data, the preprocessing stage needs several external template files. Drag **Input** nodes from the I/O section for each:

| Input label | Purpose | File you will provide at runtime |
|-------------|---------|----------------------------------|
| `MNI152_brain` | Brain-extracted MNI template for FLIRT struct→MNI registration | `$FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz` |
| `MNI152_head` | Full-head MNI template for FNIRT reference and applywarp reference | `$FSLDIR/data/standard/MNI152_T1_2mm.nii.gz` |
| `MNI152_brain_mask_dil` | Dilated brain mask for FNIRT reference masking | `$FSLDIR/data/standard/MNI152_T1_2mm_brain_mask_dil.nii.gz` |
| `fnirt_config` | FNIRT config for T1→MNI152 2mm registration | `$FSLDIR/etc/flirtsch/T1_2_MNI152_2mm.cnf` |

> The first-level GLM (Step 11) and the group analysis (Step 13) require additional input files — the GLM design matrices, contrast files, and a group brain mask. We add those Input nodes when we reach those steps, since they need explanation first.

> **Why three separate MNI files?** FLIRT struct→MNI registers the skull-stripped T1w (from BET) against the brain-extracted MNI template and matching brain-to-brain yields the best affine alignment. FNIRT, on the other hand, expects the full-head MNI template because its configuration (`T1_2_MNI152_2mm.cnf`) uses an intensity model (`--intmod=global_non_linear_with_bias`) that relies on full-head contrast to drive the nonlinear registration. The dilated brain mask (`refmask`) tells FNIRT which voxels to include in the cost function, preventing skull and background from distorting the warp.

> **Extracting template files from Docker:** If you don't have a local FSL installation, you can extract the templates from the Docker image:
> ```bash
> docker run --rm brainlife/fsl:6.0.4-patched2 \
>   cat /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz \
>   > additional_inputs/MNI152_T1_2mm_brain.nii.gz
>
> docker run --rm brainlife/fsl:6.0.4-patched2 \
>   cat /usr/local/fsl/data/standard/MNI152_T1_2mm_brain_mask_dil.nii.gz \
>   > additional_inputs/MNI152_T1_2mm_brain_mask_dil.nii.gz
> ```

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

## Step 5: Preprocessing — Compute Temporal Mean

### fslmaths (Temporal Mean)

This step computes the temporal mean of the SUSAN output — i.e., the mean intensity at each voxel across all timepoints. This 3D volume captures the baseline signal level that high-pass filtering removes. It will be added back to the filtered data in Step 6.

Drag **fslmaths** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `Tmean` | `true` | Compute mean across the time dimension — produces a 3D volume |
| `output` | `mean_func` | Output filename stem |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5 | SUSAN | `smoothed_image` | fslmaths (Tmean) | `input` |

---

## Step 6: Preprocessing — High-Pass Filter with Mean Restoration

### fslmaths (bptf + add mean)

This step combines high-pass temporal filtering and mean restoration into a single fslmaths node. fslmaths processes operations left-to-right on the command line, so the effective command is:

```
fslmaths susan_output -bptf 25 -1 -add mean_func bold_filtered
```

This applies `bptf` first (which removes the temporal mean as part of high-pass filtering, leaving zero-centered data), then immediately adds the temporal mean back in one resampling pass.

Drag a second **fslmaths** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `bptf` | `25 -1` | High-pass filter with sigma = 25 volumes; no low-pass (-1) |
| `add_file` | *(wired from Step 5)* | Add the mean_func image to each volume after filtering |
| `output` | `bold_filtered` | Output filename stem: this is the final filtered BOLD |

The `bptf` parameter performs bandpass temporal filtering. The two values are `hp_sigma` and `lp_sigma` in units of volumes (not seconds). The high-pass sigma is calculated as:

```
sigma = cutoff_period / (2 × TR) = 100 / (2 × 2) = 25 volumes
```

This applies a ~100s high-pass filter, which is the FSL default. Setting lp_sigma to `-1` disables low-pass filtering. High-pass filtering removes low-frequency scanner drift that inflates noise variance and reduces t/z-statistics. This is especially important for ds000102's slow event-related design (ITI = 8–14s), where task-related frequencies are relatively close to drift frequencies.

> **Important:** `bptf` removes the temporal mean as part of the high-pass filter, leaving the data zero-centered. This is a problem for downstream tools like `film_gls`, which uses mean intensity to distinguish brain from background, zero-centered data causes ~50% of brain voxels to be randomly masked out. Adding the temporal mean back (via `add_file`) restores positive intensities while keeping the temporal filtering. This is the standard FSL FEAT approach.

> **Why two fslmaths nodes instead of one?** The temporal mean must be computed from the *unfiltered* SUSAN output (Step 5). If you placed `Tmean` after `bptf` in the same operation chain, you'd be computing the mean of already-demeaned data (which is ~0).

Steps 5 (Tmean) and 6 (bptf + add mean) both take the SUSAN output as their primary input and can run in parallel. The `add_file` connection from Step 5 creates a dependency only on the Tmean output, not on the bptf operation within this node.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5b | SUSAN | `smoothed_image` | fslmaths (bptf + add mean) | `input` |
| 5c | fslmaths (Tmean) | `output_image` | fslmaths (bptf + add mean) | `add_file` |

> **Operation ordering in fslmaths:** fslmaths processes flags left-to-right: the order of operations on the command line determines the order of execution. When you enable two or more operations on a single fslmaths node, the **Operation Order** panel appears in the parameter modal, allowing you to reorder them with arrow buttons. In this step, the Operation Order panel shows both `bptf` and `add_file`. Use the arrow buttons to ensure **bptf executes before add_file**, this applies the high-pass filter first (which demeans the data), then adds the temporal mean back. Reversing the order would add the mean to unfiltered data and then filter it, which defeats the purpose. Wired file inputs (like `add_file`) automatically appear in the Operation Order panel when connected via edges.

---

## Step 7: Registration — Structural to MNI (Linear)

### FLIRT (12-DOF Affine, Structural → MNI)

Drag a **flirt** node onto the canvas. This is a separate FLIRT step from the functional-to-structural registration in Step 8. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `struct2mni_linear` | Output filename stem |
| `output_matrix` | `struct2mni.mat` | Save the 12-DOF affine matrix — used to initialize FNIRT |
| `dof` | `12` | Full affine (translation + rotation + scaling + skew) for inter-subject registration |
| `cost` | `corratio` | Correlation ratio — robust for T1-to-T1 registration |
| `uses_qform` | `true` | Initialize alignment from NIfTI header coordinate systems rather than center-of-gravity — critical when input and template have different qform codes or orientations |

This step computes a linear approximation of the structural-to-MNI mapping. The resulting affine matrix is passed to FNIRT as initialization, which helps FNIRT converge to a better nonlinear solution particularly for subjects whose brains differ substantially from the template. The `uses_qform` flag is important because the BET output and MNI template may have different NIfTI coordinate system codes; without it, FLIRT initializes from center-of-gravity which can converge on pathological axis-flipping transformations.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 6 | BET | `brain_extraction` | FLIRT (struct→MNI) | `input` |
| 7 | Input (`MNI152_brain`) | output | FLIRT (struct→MNI) | `reference` |

---

## Step 8: Registration — Functional to Structural

### FLIRT (6-DOF Rigid, Functional → Structural)

Drag another **flirt** node onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `func2struct` | Output filename stem |
| `dof` | `6` | 6-DOF rigid-body (functional-to-structural is intra-subject) |
| `output_matrix` | `func2struct.mat` | Save the transformation matrix — needed by applywarp |
| `cost` | `corratio` | Correlation ratio — robust for EPI-to-T1 registration |

FLIRT takes the mean functional image (from MCFLIRT) as `input` and the skull-stripped T1w (from BET) as `reference`. Using the mean BOLD, rather than the full 4D timeseries, provides a single representative volume with good tissue contrast for registration. MCFLIRT's mean image is unsmoothed and unfiltered, which preserves the tissue boundary detail needed for accurate EPI-to-T1 alignment. The SUSAN-smoothed and bptf-filtered version would have reduced edge contrast, degrading registration quality.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 8 | MCFLIRT | `mean_image` | FLIRT (func→struct) | `input` |
| 9 | BET | `brain_extraction` | FLIRT (func→struct) | `reference` |

---

## Step 9: Registration — Structural to MNI (Nonlinear)

### FNIRT (Nonlinear Registration)

Drag **fnirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `config` | `T1_2_MNI152_2mm.cnf` | FSL standard config for T1→MNI152 2mm; sets optimized warp resolution, subsampling, regularization, and intensity model |
| `cout` | `struct2mni_warp` | Output warp coefficients filename |
| `iout` | `struct2mni` | Warped output image filename |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 10 | BET | `brain_extraction` | FNIRT | `input` |
| 11 | Input (`MNI152_head`) | output | FNIRT | `reference` |
| 12 | FLIRT (struct→MNI) | `transformation_matrix` | FNIRT | `affine` |
| 13 | Input (`fnirt_config`) | output | FNIRT | `config` |
| 14 | Input (`MNI152_brain_mask_dil`) | output | FNIRT | `refmask` |

> FLIRT (struct→MNI) is from Step 7.

---

## Step 10: Transform to Standard Space

### applywarp (Apply Combined Transform)

Drag **applywarp** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_mni` | Output filename — functional data in MNI space |
| `interp` | `spline` | Spline interpolation preserves signal for functional data |

applywarp combines the linear (FLIRT) and nonlinear (FNIRT) transforms in a single resampling step, avoiding double interpolation:

- `input`: Temporally filtered BOLD with mean restored (from fslmaths bptf + add mean, Step 6)
- `reference`: MNI152 template
- `warp`: Warp field from FNIRT (Step 9)
- `premat`: Transformation matrix from FLIRT func→struct (Step 8, `func2struct.mat`)

This brings all subjects' functional data into the same standard space, which is required for group-level analysis.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 15 | fslmaths (bptf + add mean) | `output_image` | applywarp | `input` |
| 16 | Input (`MNI152_head`) | output | applywarp | `reference` |
| 17 | FNIRT | `warp_coefficients` | applywarp | `warp` |
| 18 | FLIRT (func→struct) | `transformation_matrix` | applywarp | `premat` |

The `applywarp` node outputs `warped_image` — the preprocessed BOLD in MNI152 2 mm space (`bold_mni.nii.gz`, 91×109×91 × 146 volumes). Preprocessing is now complete; the remaining steps perform the statistical analysis.

---

## Step 11: First-Level GLM (film_gls)

`film_gls` fits a general linear model to each preprocessed subject-run, estimating how strongly each voxel's time series follows the task design. It uses **FILM prewhitening** to correct for temporal autocorrelation in the fMRI noise. The node is scattered over the 52 runs, so each run gets its own GLM fit.

Each run needs **its own design matrix**, because ds000102 presents trials in a pseudorandom order — every run has unique stimulus onsets. A single shared contrast file applies to all runs.

### Generating the design files

The design matrices are built outside niBuild from the BIDS `events.tsv` files, using the `generate_designs.py` helper script provided alongside this tutorial:

```bash
python generate_designs.py \
  --bids-dir ds000102 \
  --output-dir additional_inputs/design_files \
  --tr 2.0 \
  --n-vols 146
```

This produces, in `additional_inputs/design_files/`:

- **52 per-run design matrices** (`sub-XX_run-Y_design.mat`) — one per subject-run, in the same subjects-first order as the BOLD array. Each is a **4-column** FSL design matrix with 146 rows (one per volume):

  | Column | Regressor |
  |--------|-----------|
  | 1 | Incongruent trials (boxcar convolved with a double-gamma HRF, demeaned) |
  | 2 | Incongruent temporal derivative |
  | 3 | Congruent trials (HRF-convolved, demeaned) |
  | 4 | Congruent temporal derivative |

  The temporal-derivative columns absorb small timing differences between the assumed and true HRF. No motion regressors are included.

- **`design.con`** — the first-level contrast. It defines one contrast, `incongruent_gt_baseline = [1 0 0 0]`, which isolates the incongruent regressor and tests incongruent-trial activation against the **implicit (unmodeled) resting baseline**. (A conflict contrast — incongruent > congruent — would instead be `[1 0 -1 0]`; this analysis uses the incongruent-vs-baseline contrast.)

- **`group_design.mat`, `group_design.con`, `group_design.grp`** — the group-level design files, used later in Step 13.

> The script also reads the events files directly from the BIDS dataset, so `--bids-dir` should point at the same `ds000102` folder you loaded in Step 1.

### Add the film_gls node

Drag **film_gls** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `threshold` | `100` | Intensity threshold defining the analysis mask — voxels below this value are excluded from the GLM fit |
| `results_dir` | `stats` | Name of the per-run output folder holding the COPE/VARCOPE/z-stat files |

Then add two **Input** nodes for the design files:

| Input label | Type | Purpose | File(s) you will provide at runtime |
|-------------|------|---------|--------------------------------------|
| `design_files` | File array | Per-run GLM design matrices | The 52 `sub-XX_run-Y_design.mat` files, in BOLD-array order |
| `contrast_file` | File | First-level contrast | `design.con` |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 19 | applywarp | `warped_image` | film_gls | `input` |
| 20 | Input (`design_files`) | output | film_gls | `design_file` |
| 21 | Input (`contrast_file`) | output | film_gls | `contrast_file` |

> **Scatter alignment:** film_gls scatters over `input` and `design_file` together (`dotproduct`), pairing the i-th BOLD run with the i-th design matrix. The `design_files` array must therefore be in the **same subjects-first order** as the BOLD array (`sub-01` run-1, `sub-01` run-2, `sub-02` run-1, …). `generate_designs.py` writes the files in exactly this order, and the job-file list in Step 16 preserves it.

Each scattered film_gls run outputs a `stats/` folder containing `cope1.nii.gz` (the contrast estimate), `varcope1.nii.gz` (its variance), `zstat1.nii.gz`, `tstat1.nii.gz`, parameter estimates, and residuals. The `cope` and `varcope` outputs feed the group analysis.

---

## Step 12: Merge COPEs and VARCOPEs

The group analysis needs every run's contrast estimate stacked into a single 4D file. Two `fslmerge` nodes do this — one for the COPEs, one for the VARCOPEs.

Drag **two fslmerge** nodes onto the canvas. Double-click each and set:

| Node | Parameter | Value |
|------|-----------|-------|
| fslmerge (COPEs) | `dimension` | `t` |
| fslmerge (COPEs) | `output` | `all_copes` |
| fslmerge (VARCOPEs) | `dimension` | `t` |
| fslmerge (VARCOPEs) | `output` | `all_varcopes` |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 22 | film_gls | `cope` | fslmerge (COPEs) | `input_files` |
| 23 | film_gls | `varcope` | fslmerge (VARCOPEs) | `input_files` |

> **This is the gather point.** film_gls is scattered, so its `cope` and `varcope` outputs are *arrays* of 52 files. The fslmerge nodes are **not** scattered — connecting a scattered output to their `input_files` port collects the whole array. Each `fslmerge` concatenates the 52 volumes along the time dimension (`-t`), producing `all_copes.nii.gz` and `all_varcopes.nii.gz`, each with 52 volumes. The volume order matches the scatter order (subjects-first), which must line up with the group design matrix in Step 13.

---

## Step 13: Group-Level Analysis (FLAMEO)

`FLAMEO` (FMRIB's Local Analysis of Mixed Effects) performs the group-level statistical analysis. It takes the 52 stacked COPEs and VARCOPEs and estimates the average task effect across runs, accounting for both within-run and between-run variance.

### Group design files

These were already generated by `generate_designs.py` in Step 11:

- **`group_design.mat`** — a 52×1 matrix, a single column of ones. This is a one-sample **group mean model**: it estimates the average `incongruent > baseline` effect across all runs.
- **`group_design.con`** — the group contrast, `[1]`, testing whether that mean effect differs from zero.
- **`group_design.grp`** — the covariance-split file. All 52 runs are assigned to a **single group**, so FLAMEO estimates one shared between-observation variance.

> **What the group model does and does not do:** This design treats all 52 runs as independent observations of the task effect — it does not nest the two runs within each subject. It is the simplest valid group model and is what this validation analysis runs. A subject-level random-effects analysis would instead average the two runs within each subject (or add a subject grouping) before the group fit.

### Add the flameo node

Drag **flameo** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `run_mode` | `flame1` | FLAME stage 1 — fast mixed-effects estimation of the between-run variance |
| `log_dir` | `stats` | Name of the output folder for the group statistics |

Add four **Input** nodes for the group files:

| Input label | Type | Purpose | File you will provide at runtime |
|-------------|------|---------|----------------------------------|
| `group_design` | File | Group design matrix | `group_design.mat` |
| `group_contrast` | File | Group t-contrast | `group_design.con` |
| `group_cov_split` | File | Covariance-split (group assignment) | `group_design.grp` |
| `MNI152_brain_mask` | File | Analysis mask (group space) | `$FSLDIR/data/standard/MNI152_T1_2mm_brain_mask.nii.gz` |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 24 | fslmerge (COPEs) | `merged_image` | flameo | `cope_file` |
| 25 | fslmerge (VARCOPEs) | `merged_image` | flameo | `var_cope_file` |
| 26 | Input (`group_design`) | output | flameo | `design_file` |
| 27 | Input (`group_contrast`) | output | flameo | `t_con_file` |
| 28 | Input (`group_cov_split`) | output | flameo | `cov_split_file` |
| 29 | Input (`MNI152_brain_mask`) | output | flameo | `mask_file` |

FLAMEO writes a `stats/` folder containing the group `zstat1.nii.gz`, `cope1.nii.gz`, `tstat1.nii.gz`, `varcope1.nii.gz`, and `tdof_t1.nii.gz`. **`zstat1.nii.gz` is the group activation map** — the final output of the workflow. Thresholding it at, e.g., z > 3.1 highlights voxels reliably engaged by incongruent flanker trials.

---

## Step 14: Pin Docker Versions

For reproducibility, pin a specific FSL version on each node rather than relying on a floating tag.

1. Double-click an FSL node (e.g., BET).
2. In the parameter modal, find the **Docker version** dropdown.
3. Select an explicit version such as `6.0.4` or `6.0.5`.
4. Repeat for each node.

All FSL tools use the `brainlife/fsl` Docker image. The nodes in this workflow default to a mix of tags — the preprocessing and registration tools run on `6.0.4`, `film_gls` runs on `6.0.4-patched2` (a build that fixes a `film_gls` masking bug), and the `fslmerge`/`flameo` nodes run on `latest`. Pinning every node to an explicit version avoids surprises if `latest` changes.

---

## Step 15: Name and Export

1. In the top bar, set the **Output** name to `flanker_analysis` (or any name you prefer).
2. Click the **Generate Workflow** button in the actions bar.
3. Your browser downloads `flanker_analysis.crate.zip`.

The ZIP contains:

```
flanker_analysis.crate.zip/
├── workflows/
│   ├── flanker_analysis.cwl           # Main CWL workflow
│   └── flanker_analysis_job.yml       # Job template with your parameter values
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

## Step 16: Run the Workflow

Unzip the bundle and edit the job file before running. The design files generated in Step 11 must already exist — place the `design_files/` folder where the job file can reach it (e.g., `additional_inputs/design_files/`).

### Edit the job template

Open `workflows/flanker_analysis_job.yml`. Replace placeholder paths with actual paths on your system:

```yaml
# BIDS-resolved inputs (filled by resolve_bids.py or manually)
# 52 entries, subjects-first: sub-01 run-1, sub-01 run-2, sub-02 run-1, ...
bold:
  - class: File
    path: /data/sub-01/func/sub-01_task-flanker_run-1_bold.nii.gz
  - class: File
    path: /data/sub-01/func/sub-01_task-flanker_run-2_bold.nii.gz
  - class: File
    path: /data/sub-02/func/sub-02_task-flanker_run-1_bold.nii.gz
  - class: File
    path: /data/sub-02/func/sub-02_task-flanker_run-2_bold.nii.gz
  # ... (sub-03 through sub-26, each run-1 then run-2)

# T1w images: each subject's T1w is listed twice (once per run) so that
# the t1w array length (52) matches the bold array length (52). This is
# required because dotproduct scatter pairs arrays element-by-element —
# the i-th bold file must align with the i-th t1w file.
t1w:
  - class: File                              # sub-01, run-1
    path: /data/sub-01/anat/sub-01_T1w.nii.gz
  - class: File                              # sub-01, run-2 (same T1w)
    path: /data/sub-01/anat/sub-01_T1w.nii.gz
  - class: File                              # sub-02, run-1
    path: /data/sub-02/anat/sub-02_T1w.nii.gz
  - class: File                              # sub-02, run-2 (same T1w)
    path: /data/sub-02/anat/sub-02_T1w.nii.gz
  # ... (sub-03 through sub-26, each listed twice)

# --- Preprocessing template inputs ---
# Brain-extracted MNI template (used by FLIRT struct→MNI)
flirt_1_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm_brain.nii.gz

# Full-head MNI template (used by FNIRT and applywarp — two separate keys)
fnirt_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz
applywarp_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz

# FNIRT config and dilated reference mask
fnirt_config:
  class: File
  path: /data/additional_inputs/T1_2_MNI152_2mm.cnf
fnirt_refmask:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm_brain_mask_dil.nii.gz

# --- First-level GLM inputs (Step 11) ---
# 52 per-run design matrices, SAME subjects-first order as the bold array
film_gls_design_file:
  - class: File
    path: /data/additional_inputs/design_files/sub-01_run-1_design.mat
  - class: File
    path: /data/additional_inputs/design_files/sub-01_run-2_design.mat
  - class: File
    path: /data/additional_inputs/design_files/sub-02_run-1_design.mat
  # ... (sub-02 run-2 through sub-26 run-2)
film_gls_contrast_file:
  class: File
  path: /data/additional_inputs/design_files/design.con

# --- Group-level inputs (Step 13) ---
flameo_mask_file:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm_brain_mask.nii.gz
flameo_design_file:
  class: File
  path: /data/additional_inputs/design_files/group_design.mat
flameo_t_con_file:
  class: File
  path: /data/additional_inputs/design_files/group_design.con
flameo_cov_split_file:
  class: File
  path: /data/additional_inputs/design_files/group_design.grp

# Tool parameters (pre-filled from your canvas configuration)
bet_output: brain
bet_frac: 0.5
bet_mask: true
mcflirt_output: bold_mc
mcflirt_mean_vol: true
mcflirt_save_plots: true
slicetimer_output: bold_st
susan_brightness_threshold: 2000
susan_fwhm: 5
susan_output: bold_smooth
# fslmaths (Tmean) — compute temporal mean before filtering
fslmaths_1_Tmean: true
fslmaths_1_output: mean_func
# fslmaths (bptf + add mean) — filter and restore mean in one pass
# add_file is wired from fslmaths_1 output via canvas connection
fslmaths_2_bptf: "25 -1"
fslmaths_2_output: bold_filtered
flirt_1_output: struct2mni_linear
flirt_1_output_matrix: struct2mni.mat
flirt_1_dof: 12
flirt_1_cost: corratio
flirt_1_uses_qform: true
flirt_2_output: func2struct
flirt_2_output_matrix: func2struct.mat
flirt_2_dof: 6
flirt_2_cost: corratio
fnirt_cout: struct2mni_warp
fnirt_iout: struct2mni
applywarp_output: bold_mni
applywarp_interp: spline
# First-level GLM
film_gls_threshold: 100
film_gls_results_dir: stats
# Merge copes / varcopes across runs
fslmerge_1_dimension: t
fslmerge_1_output: all_copes
fslmerge_2_dimension: t
fslmerge_2_output: all_varcopes
# Group-level mixed-effects
flameo_run_mode: flame1
flameo_log_dir: stats
```

If you used BIDS data, you can run `resolve_bids.py` to auto-populate the `bold` and `t1w` file paths:

```bash
python resolve_bids.py /path/to/bids/dataset
```

`resolve_bids.py` and `generate_designs.py` both emit the 52 entries in the same subjects-first order, so the `bold`, `t1w`, and `film_gls_design_file` arrays stay aligned.

### Option A: Run with Docker

```bash
cd flanker_analysis

# Optional: pre-pull FSL images
bash prefetch_images.sh

# Build the orchestration container
docker build -t flanker-analysis .

# Run
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  flanker-analysis
```

The `-v /var/run/docker.sock:/var/run/docker.sock` mount is required because cwltool inside the container launches per-tool Docker containers (Docker-in-Docker pattern).

### Option B: Run with cwltool directly

```bash
pip install cwltool
cd flanker_analysis
cwltool --parallel --cachedir cache \
  workflows/flanker_analysis.cwl workflows/flanker_analysis_job.yml
```

This requires Docker to be running, as cwltool pulls the `brainlife/fsl` image to execute each step.

> **`--parallel` and `--cachedir`:** `--parallel` runs the scattered subject-runs concurrently — without it, cwltool processes the 52 runs sequentially even though scatter is specified. `--cachedir cache` caches completed step outputs, so an interrupted run resumes instead of restarting, and duplicate structural processing on the repeated T1w inputs (BET, FLIRT struct→MNI, FNIRT) is computed only once per subject.

### Option C: Run with Singularity (HPC)

```bash
cd flanker_analysis

# Convert Docker images to SIF
bash prefetch_images_singularity.sh

# Build the orchestration container
singularity build flanker-analysis.sif Singularity.def

# Run
singularity run \
  --bind /path/to/data:/data \
  --bind /path/to/output:/output \
  flanker-analysis.sif
```

---

## Expected Outputs

### Per subject-run preprocessing outputs

The preprocessing stage produces MNI-space preprocessed BOLD for each subject-run (52 total):

| File | Step | Description |
|------|------|-------------|
| `brain.nii.gz` | BET | Skull-stripped T1w structural |
| `brain_mask.nii.gz` | BET | Binary brain mask |
| `bold_mc.nii.gz` | MCFLIRT | Motion-corrected 4D BOLD |
| `bold_mc.par` | MCFLIRT | 6-DOF motion parameters (3 rot + 3 trans) |
| `bold_st.nii.gz` | slicetimer | Slice-timing corrected BOLD |
| `bold_smooth.nii.gz` | SUSAN | Spatially smoothed BOLD |
| `bold_filtered.nii.gz` | fslmaths | High-pass filtered BOLD with mean restored |
| `struct2mni_linear.nii.gz` | FLIRT | Linearly registered structural |
| `func2struct.mat` | FLIRT | Functional-to-structural transform |
| `struct2mni_warp.nii.gz` | FNIRT | Nonlinear warp field |
| `bold_mni.nii.gz` | applywarp | Preprocessed BOLD in MNI space |

### First-level GLM outputs (per subject-run)

Each of the 52 film_gls runs produces a `stats/` folder:

| File | Description |
|------|-------------|
| `stats/cope1.nii.gz` | Contrast of parameter estimates (incongruent > baseline) |
| `stats/varcope1.nii.gz` | Variance of the COPE |
| `stats/zstat1.nii.gz` | Per-run z-statistic map |
| `stats/tstat1.nii.gz` | Per-run t-statistic map |
| `stats/pe*.nii.gz` | Parameter estimates for each design column |

### Group-level outputs

| File | Step | Description |
|------|------|-------------|
| `all_copes.nii.gz` | fslmerge | 52 per-run COPEs concatenated (4D) |
| `all_varcopes.nii.gz` | fslmerge | 52 per-run VARCOPEs concatenated (4D) |
| `stats/cope1.nii.gz` | FLAMEO | Group mean contrast estimate |
| `stats/tstat1.nii.gz` | FLAMEO | Group t-statistic map |
| `stats/tdof_t1.nii.gz` | FLAMEO | Degrees of freedom (51 = 52 runs − 1) |
| `stats/zstat1.nii.gz` | FLAMEO | **Final output — group activation map (incongruent > baseline)** |

View the group `zstat1.nii.gz` overlaid on the MNI152 template in FSLeyes, MRIcroGL, or any NIfTI viewer; threshold at z > 3.1 to display reliably activated voxels.

---

## Tips

**Multi-subject processing with scatter:**
Because BIDS outputs are arrays (one file per subject-run), scatter automatically parallelizes the pipeline across subject-runs from BET all the way through film_gls. The two `fslmerge` nodes are where the 52 parallel streams converge for the group analysis.

**Caching duplicate structural processing:**
Because T1w images are duplicated to match the BOLD array length (see Step 1), BET, FLIRT struct→MNI, and FNIRT would each run twice per subject — once for each run — producing identical outputs. When using `--cachedir`, cwltool detects that the same T1w file appears twice in the array and reuses the cached outputs. This means structural processing runs only once per subject, not once per run. Without `--cachedir`, the duplicate processing still produces correct results but wastes compute.

**Keep the design-file array aligned:**
The `film_gls_design_file` array must be in the same subjects-first order as the `bold` array — film_gls pairs them element-by-element via `dotproduct` scatter. `generate_designs.py` writes the design matrices in this order; if you build the array by hand, double-check it against the `bold` list.

**Save as a custom workflow:**
To reuse this pipeline in other projects, type a name in the **Name** field (top bar) and click **Save Workflow**. The pipeline appears under **My Workflows** in the left menu and can be dragged onto any future canvas as a single composite node.

**Use the CWL Preview panel:**
Before exporting, open the CWL Preview panel to inspect the generated CWL and job YAML in real time. This helps catch wiring mistakes or missing parameters before you download the bundle.

**Motion QC:**
Before trusting the group result, inspect the motion parameter plots from MCFLIRT. Consider excluding subject-runs with excessive motion (e.g., > 3mm translation or > 3° rotation). In a production pipeline, you would add a QC step here — niBuild includes MRIQC as a single-node option for automated quality assessment.
