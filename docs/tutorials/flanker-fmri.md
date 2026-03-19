# fMRI Flanker Task Analysis Tutorial

This tutorial walks through building an fMRI preprocessing pipeline for the Eriksen flanker task using niBuild. By the end, you will have a portable, reproducible workflow bundle that preprocesses BOLD data and registers it to standard (MNI) space which is the same endpoint as fMRIPrep. Statistical analysis (first-level GLM, group-level inference) may be performed separately downstream.

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

The workflow chains eleven FSL tools into a complete preprocessing → registration pipeline. It includes high-pass temporal filtering (with mean restoration) to remove scanner drift, affine initialization for nonlinear registration, and processes both runs per subject. The pipeline ends at applywarp, producing MNI-space preprocessed BOLD — the same endpoint as fMRIPrep:

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

For the `bold` output, check **Include events** if you want the events TSV files bundled alongside the BOLD data. Make sure **both runs** are selected as ds000102 contains two runs per subject, and including both doubles the within-subject trial count from 24 to 48, substantially boosting statistical power.

Click **Save**. The BIDS node now appears on the canvas with two output ports: `bold` and `t1w`. Scatter is automatically enabled because BIDS outputs are file arrays. The `bold` array will contain 52 files (26 subjects × 2 runs), and the `t1w` array will contain 52 entries (each subject's T1w is duplicated to match the bold array length).

> **Why T1w must be duplicated to match the BOLD array length:**
> Several downstream steps use `dotproduct` scatter to pair functional and structural data element-by-element. For example, FLIRT (func→struct) scatters over both `mcflirt/mean_image` (52 functional files) and `bet/brain_extraction` (from the T1w array) simultaneously meaning the i-th functional file is paired with the i-th structural file. Similarly, applywarp scatters over functional data, FNIRT warp coefficients, and FLIRT transformation matrices together. CWL's `dotproduct` requires all scattered arrays to have the same length. Since there are 52 BOLD files (26 subjects × 2 runs) but only 26 unique T1w images, each T1w must appear twice so that the structural array (52) matches the functional array (52). When using `--cachedir`, cwltool detects duplicate T1w inputs and reuses cached BET/FLIRT/FNIRT outputs, so structural processing still only runs once per subject.

---

## Step 2: Add Input Nodes

In addition to BIDS data, the pipeline needs several external files. Drag **Input** nodes from the I/O section for each:

| Input label | Purpose | File you will provide at runtime |
|-------------|---------|----------------------------------|
| `MNI152` | Standard space template for registration | `$FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz` |
| `fnirt_config` | FNIRT config for T1→MNI152 2mm registration | `$FSLDIR/etc/flirtsch/T1_2_MNI152_2mm.cnf` |

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

> **Operation ordering in fslmaths:** fslmaths processes flags left-to-right — the order of operations on the command line determines the order of execution. When you enable two or more operations on a single fslmaths node, the **Operation Order** panel appears in the parameter modal, allowing you to reorder them with arrow buttons. In this pipeline, each fslmaths node performs a single operation (bptf, Tmean, or add_file), so operation ordering is not needed. If you were to consolidate steps — for example, combining `-thr 0.5` and `-bin` into one node — you would use the Operation Order panel to control whether thresholding or binarization happens first, as these produce different results. Wired file inputs (like `add_file`) automatically appear in the Operation Order panel when connected via edges.

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
| `config` | `T1_2_MNI152_2mm.cnf` | FSL standard config for T1→MNI152 2mm; sets optimized warp resolution, subsampling, regularization, and intensity model |
| `cout` | `struct2mni_warp` | Output warp coefficients filename |
| `iout` | `struct2mni` | Warped output image filename |

FNIRT takes the skull-stripped T1w (from BET) as `input`, the MNI152 template as `reference`, and the 12-DOF affine matrix from Step 8 as `affine` initialization. The `config` parameter points to FSL's standard configuration file for T1-to-MNI152 2mm registration. It overrides FNIRT's generic defaults with settings tuned for this specific registration: 10mm→2mm warp resolution schedule, appropriate subsampling levels, and regularization that balances anatomical detail against overfitting. Without it, FNIRT uses conservative defaults that may under-warp cortical folds.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 10 | BET | `brain_extraction` | FNIRT | `input` |
| 11 | Input (`MNI152`) | output | FNIRT | `reference` |
| 12 | FLIRT (struct→MNI) | `transformation_matrix` | FNIRT | `affine` |
| 13 | Input (`fnirt_config`) | output | FNIRT | `config` |

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
| 14 | fslmaths (add mean) | `output_image` | applywarp | `input` |
| 15 | Input (`MNI152`) | output | applywarp | `reference` |
| 16 | FNIRT | `warp_coefficients` | applywarp | `warp` |
| 17 | FLIRT (func→struct) | `transformation_matrix` | applywarp | `premat` |

**Optional: First-Level and Group-Level Statistics**

To extend this pipeline for task activation analysis (e.g., incongruent > congruent contrast), add film_gls for per-subject-run first-level GLMs — each subject-run receives its own design matrix encoding congruent and incongruent trial onsets convolved with the hemodynamic response function, plus a contrast file defining the comparison of interest. The per-subject-run COPEs (contrast of parameter estimates) and VARCOPEs are then gathered via fslmerge into 4D volumes, and flameo performs group-level mixed-effects analysis (FLAME1) across subjects. Because ds000102 uses pseudorandom trial ordering, each subject-run requires its own design matrix generated from the BIDS events.tsv files. The group design uses a single-column mean model with a `.grp` file encoding the repeated-measures structure (2 runs per subject).

---

> **Scatter propagation:** Because the BIDS node has scatter enabled, scatter automatically propagates downstream through all connected nodes from BET through applywarp. Each subject-run is preprocessed independently. When using `--cachedir` with cwltool, duplicate T1w processing (BET, FLIRT struct→MNI, FNIRT) is automatically cached — the second run reuses the first run's structural results.

---

## Step 12: Pin Docker Versions

For reproducibility, pin a specific FSL version rather than using `latest`.

1. Double-click any FSL node (e.g., BET).
2. In the parameter modal, find the **Docker version** dropdown.
3. Select a version such as `6.0.5` or `6.0.4-patched2`.
4. Repeat for each FSL node, or set them all to the same version.

All FSL tools use the `brainlife/fsl` Docker image, so they share the same version tag.

---

## Step 13: Name and Export

1. In the top bar, set the **Output** name to `flanker_preproc` (or any name you prefer).
2. Click the **Generate Workflow** button in the actions bar.
3. Your browser downloads `flanker_preproc.crate.zip`.

The ZIP contains:

```
flanker_preproc.crate.zip/
├── workflows/
│   ├── flanker_preproc.cwl           # Main CWL workflow
│   └── flanker_preproc_job.yml       # Job template with your parameter values
├── cwl/
│   └── fsl/
│       ├── bet.cwl
│       ├── mcflirt.cwl
│       ├── slicetimer.cwl
│       ├── susan.cwl
│       ├── fslmaths.cwl
│       ├── flirt.cwl
│       ├── fnirt.cwl
│       └── applywarp.cwl
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

## Step 14: Run the Workflow

Unzip the bundle and edit the job file before running.

### Edit the job template

Open `workflows/flanker_preproc_job.yml`. Replace placeholder paths with actual paths on your system:

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

# FNIRT config for T1→MNI152 2mm
fnirt_config:
  class: File
  path: /data/additional_inputs/T1_2_MNI152_2mm.cnf

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
cd flanker_preproc

# Optional: pre-pull FSL images
bash prefetch_images.sh

# Build the orchestration container
docker build -t flanker-preproc .

# Run
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  flanker-preproc
```

The `-v /var/run/docker.sock:/var/run/docker.sock` mount is required because cwltool inside the container launches per-tool Docker containers (Docker-in-Docker pattern).

### Option B: Run with cwltool directly

```bash
pip install cwltool
cd flanker_preproc
cwltool --parallel --cachedir cache \
  workflows/flanker_preproc.cwl workflows/flanker_preproc_job.yml
```

> **Note:** `--parallel` enables concurrent execution of scattered subject-runs — without it, cwltool processes each sequentially even when scatter is specified. `--cachedir cache` caches completed step outputs so that if the workflow is interrupted, re-running it skips already-finished jobs. With both runs included, caching also avoids redundant BET/FLIRT/FNIRT computation on duplicate T1w inputs.

This requires Docker to be running, as cwltool pulls the `brainlife/fsl` image to execute each step.

### Option C: Run with Singularity (HPC)

```bash
cd flanker_preproc

# Convert Docker images to SIF
bash prefetch_images_singularity.sh

# Build the orchestration container
singularity build flanker-preproc.sif Singularity.def

# Run
singularity run \
  --bind /path/to/data:/data \
  --bind /path/to/output:/output \
  flanker-preproc.sif
```

---

## Expected Outputs

### Per subject-run preprocessing outputs

The pipeline produces MNI-space preprocessed BOLD for each subject-run (52 total). Key intermediate and final outputs:

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
| `bold_mni.nii.gz` | applywarp | **Final output — preprocessed BOLD in MNI space** |

The `bold_mni.nii.gz` files are ready for downstream statistical analysis (e.g., first-level GLM via film_gls/FEAT, or connectivity analysis).

You can view these outputs overlaid on the MNI152 template in FSLeyes, MRIcroGL, or any NIfTI viewer.

---

## Tips

**Multi-subject processing with scatter:**
Because BIDS outputs are arrays (one file per subject-run), scatter automatically parallelizes the entire pipeline across subject-runs. Each subject-run is preprocessed independently through BET to applywarp.

**Temporal filtering and mean restoration:**
`fslmaths -bptf` removes the temporal mean as part of high-pass filtering, leaving the data zero-centered. This is a common pitfall; FSL's FEAT handles it automatically by computing `-Tmean` before filtering and `-add`ing it back afterward. The pipeline includes three fslmaths steps (Steps 5–7) to replicate this pattern: compute the temporal mean, apply the high-pass filter, then add the mean back.

**Caching duplicate structural processing:**
Because T1w images are duplicated to match the BOLD array length (see Step 1), BET, FLIRT struct→MNI, and FNIRT would each run twice per subject — once for each run — producing identical outputs. When using `--cachedir`, cwltool detects that the same T1w file appears twice in the array and reuses the cached outputs. This means structural processing only runs once per subject, not once per run. Without `--cachedir`, the duplicate processing still produces correct results but wastes compute.

**Save as a custom workflow:**
To reuse this pipeline in other projects, type a name in the **Name** field (top bar) and click **Save Workflow**. The pipeline appears under **My Workflows** in the left menu and can be dragged onto any future canvas as a single composite node.

**Use the CWL Preview panel:**
Before exporting, open the CWL Preview panel to inspect the generated CWL and job YAML in real time. This helps catch wiring mistakes or missing parameters before you download the bundle.

**Motion QC:**
Before proceeding to downstream analysis, inspect the motion parameter plots from MCFLIRT. Consider excluding subjects with excessive motion (e.g., > 3mm translation or > 3° rotation). In a production pipeline, you would add a QC step here — niBuild includes MRIQC as a single-node option for automated quality assessment.
