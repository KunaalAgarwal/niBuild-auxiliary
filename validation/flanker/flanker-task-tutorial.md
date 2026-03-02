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

The workflow chains nine FSL tools into a complete preprocessing → registration → statistics pipeline. An fslmerge step gathers per-subject first-level results into 4D volumes before group analysis:

```
BIDS Dataset
  ├─ t1w ──> BET ──────────────────────────────────────> FLIRT (reference)
  │            └──────────────────────────────────────────> FNIRT (input)
  │                                                            │
  └─ bold ─> MCFLIRT ─> slicetimer ─> SUSAN ──────> FLIRT ─> applywarp ─> film_gls ─> fslmerge ─> flameo
                                                       │                      ↑                      ↑
                                               MNI152 ─┤─> FNIRT (ref)  design.mat[]          design.mat
                                                       │                 contrast.con          contrast.con
                                                       └─> applywarp (ref)                    cov_split.grp
```

| Step | Tool | Purpose |
|------|------|---------|
| 1 | BET | Skull-strip the T1w structural image |
| 2 | MCFLIRT | Correct head motion in the BOLD time series |
| 3 | slicetimer | Correct inter-slice acquisition timing |
| 4 | SUSAN | Spatially smooth the functional data |
| 5 | FLIRT | Register functional data to the structural image (linear, 6-DOF) |
| 6 | FNIRT | Register structural image to MNI152 template (nonlinear) |
| 7 | applywarp | Apply combined func→struct→MNI transform to functional data |
| 8 | film_gls | Fit the first-level GLM with prewhitening (per-subject statistics) |
| 9 | fslmerge | Concatenate per-subject COPEs/VARCOPEs into 4D volumes for group analysis |
| 10 | flameo | Group-level mixed-effects analysis across subjects |

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
- Click the **func** chip and the **anat** chip so both are checked.

**Output group configuration (bottom-right):**

Create two output groups by clicking the **Add output** button:

| Output label | Datatype | Suffix | Task filter |
|--------------|----------|--------|-------------|
| `bold` | func | bold | flanker |
| `t1w` | anat | T1w | — |

For the `bold` output, check **Include events** if you want the events TSV files bundled alongside the BOLD data.

Click **Save**. The BIDS node now appears on the canvas with two output ports: `bold` and `t1w`. Scatter is automatically enabled because BIDS outputs are file arrays (one file per subject).

---

## Step 2: Add Input Nodes

In addition to BIDS data, the pipeline needs several external files. Drag **Input** nodes from the I/O section for each:

| Input label | Purpose | File you will provide at runtime |
|-------------|---------|----------------------------------|
| `MNI152` | Standard space template for registration | `$FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz` |
| `MNI_mask` | Brain mask in standard space for group analysis | `$FSLDIR/data/standard/MNI152_T1_2mm_brain_mask.nii.gz` |
| `design_matrices` | Per-subject first-level GLM design matrices (File[]) | Generated from events.tsv (see Step 9) |
| `contrasts` | First-level contrast definitions | Custom `.con` file (see Step 9) |
| `group_design` | Group-level design matrix | Simple one-column design (see Step 11) |
| `group_contrasts` | Group-level contrasts | Simple mean contrast (see Step 11) |
| `group_covariance` | Group-level covariance structure | `.grp` file (see Step 11) |

> **Note:** The `design_matrices` input is a **File array** — one design matrix per subject — because ds000102 uses pseudorandom trial ordering and each subject has different congruent/incongruent onset times. This input is scattered alongside the BOLD data via dotproduct.

---

## Step 3: Preprocessing — Brain Extraction

### BET (Brain Extraction)

Drag **bet** onto the canvas. Double-click the node to open its parameter modal and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `brain` | Output filename stem |
| `frac` | `0.5` | Fractional intensity threshold (default; lower values include more tissue) |
| `mask` | `true` | Also generate a binary brain mask |

BET operates on the T1w structural image. The skull-stripped brain serves as the reference for functional-to-structural registration (FLIRT) and as the input for structural-to-MNI registration (FNIRT).

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

> **Note:** Check your acquisition protocol. If unsure, inspect the `SliceTiming` field in the BOLD sidecar JSON (`sub-XX_task-flanker_bold.json`).

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

## Step 5: Registration — Functional to Structural

### FLIRT (Linear Registration)

Drag **flirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `func2struct` | Output filename stem |
| `dof` | `6` | 6-DOF rigid-body (functional-to-structural is intra-subject) |
| `output_matrix` | `func2struct.mat` | Save the transformation matrix — needed by applywarp |
| `cost` | `corratio` | Correlation ratio — robust for EPI-to-T1 registration |

FLIRT takes the smoothed BOLD as `input` and the skull-stripped T1w (from BET) as `reference`.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5 | SUSAN | `smoothed_image` | FLIRT | `input` |
| 6 | BET | `brain_extraction` | FLIRT | `reference` |

---

## Step 6: Registration — Structural to MNI

### FNIRT (Nonlinear Registration)

Drag **fnirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `cout` | `struct2mni_warp` | Output warp coefficients filename |
| `iout` | `struct2mni` | Warped output image filename |

FNIRT takes the skull-stripped T1w (from BET) as `input` and the MNI152 template (from the Input node) as `reference`. It produces a nonlinear warp field that maps structural space to MNI space.

> **Note:** FNIRT expects an affine initialization. If needed, run a 12-DOF FLIRT (structural → MNI) first and provide the resulting matrix via FNIRT's `affine` parameter. For many datasets, FNIRT's internal initialization is sufficient.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 7 | BET | `brain_extraction` | FNIRT | `input` |
| 8 | Input (`MNI152`) | output | FNIRT | `reference` |

---

## Step 7: Transform to Standard Space

### applywarp (Apply Combined Transform)

Drag **applywarp** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_mni` | Output filename — functional data in MNI space |
| `interp` | `spline` | Spline interpolation preserves signal for functional data |

applywarp combines the linear (FLIRT) and nonlinear (FNIRT) transforms in a single resampling step, avoiding double interpolation:

- `input`: Smoothed BOLD (from SUSAN)
- `reference`: MNI152 template
- `warp`: Warp field from FNIRT
- `premat`: Transformation matrix from FLIRT (`func2struct.mat`)

This brings all subjects' functional data into the same standard space, which is required for group-level analysis.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 9 | SUSAN | `smoothed_image` | applywarp | `input` |
| 10 | Input (`MNI152`) | output | applywarp | `reference` |
| 11 | FNIRT | `warp_coefficients` | applywarp | `warp` |
| 12 | FLIRT | `transformation_matrix` | applywarp | `premat` |

---

## Step 8: First-Level Statistics

### film_gls (General Linear Model)

Drag **film_gls** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `threshold` | `1000` | Default FILM estimation threshold |
| `results_dir` | `stats` | Name for the output results directory |
| `smooth_autocorr` | `true` | Smooth autocorrelation estimates for stable prewhitening |

film_gls takes the MNI-space BOLD (from applywarp) as `input`, plus two external files:

1. **Design matrix** (`.mat` file) — encodes the GLM regressors (one per subject)
2. **Contrast file** (`.con` file) — defines the contrast of interest (shared across subjects)

film_gls scatters on both `input` and `design_file` using **dotproduct**, so each subject receives its own BOLD data paired with its own design matrix. The contrast file is broadcast to all subjects.

film_gls produces per-subject COPEs (contrast of parameter estimates), VARCOPEs (variance estimates), and t/z-statistic maps.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 13 | applywarp | `warped_image` | film_gls | `input` |
| 14 | Input (`design_matrices`) | output | film_gls | `design_file` |
| 15 | Input (`contrasts`) | output | film_gls | `contrast_file` |

---

## Step 9: Preparing the First-Level Design

The first-level design matrix encodes the experimental conditions for each subject. Because ds000102 uses pseudorandom trial ordering (each subject sees a different sequence of congruent and incongruent trials), **each subject needs its own design matrix**.

**Event structure (ds000102):**
- 24 trials per run (12 congruent, 12 incongruent)
- 2-second stimulus duration
- Variable inter-trial interval (8–14 s, mean 12 s)
- TR = 2.0 s, ~150 volumes per run

**Regressors (2 columns):**
1. Congruent trials — onsets and durations convolved with a double-gamma HRF
2. Incongruent trials — onsets and durations convolved with a double-gamma HRF

**Contrast (incongruent > congruent):**

Use a single contrast to keep the pipeline straightforward. With one contrast, film_gls produces exactly one COPE and one VARCOPE per subject, which simplifies the downstream merge into 4D volumes.

```
/NumWaves 2
/NumContrasts 1
/Matrix
-1 1
```

This contrast tests for greater activation during incongruent relative to congruent trials — the core cognitive control contrast.

**Creating the design files:**

Option A: Use FSL's `Glm` GUI to design the matrix interactively.

Option B: Use a script to generate subject-specific designs from the BIDS events.tsv files:

```python
# Pseudocode for generating per-subject designs from BIDS events
import pandas as pd
import numpy as np

events = pd.read_csv('sub-01_task-flanker_run-1_events.tsv', sep='\t')
incongruent = events[events['Stimulus'] == 'incongruent']
congruent = events[events['Stimulus'] == 'congruent']

# Create onset vectors, convolve with double-gamma HRF, sample at TR=2.0s
# Repeat for each subject, output as FSL .mat format (VEST)
```

The script should produce one `.mat` file per subject (26 total). These are provided as a File array to the `design_matrices` input.

---

## Step 10: Merge Per-Subject Results

### fslmerge (Concatenate 4D Volumes)

After film_gls completes for all subjects, the per-subject COPEs and VARCOPEs must be concatenated into single 4D volumes for group analysis. This requires **two fslmerge nodes** — one for COPEs and one for VARCOPEs.

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

The fslmerge inputs receive the scattered film_gls outputs. Because film_gls was scattered across subjects, its `cope` and `varcope` outputs are nested arrays (`File[][]`). The edge connection flattens these with `$(self.flat())` into a single `File[]` that fslmerge concatenates into a 4D volume.

With a single first-level contrast, each subject contributes one COPE and one VARCOPE, so the merged 4D volumes have 26 volumes (one per subject) — exactly what flameo expects.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 16 | film_gls | `cope` | fslmerge (COPEs) | `input_files` |
| 17 | film_gls | `varcope` | fslmerge (VARCOPEs) | `input_files` |

---

## Step 11: Group-Level Statistics

### flameo (FMRIB's Local Analysis of Mixed Effects)

Drag **flameo** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `run_mode` | `flame1` | FLAME 1 mixed-effects model — standard for group fMRI |

flameo takes the following inputs:

- `cope_file`: The merged 4D COPE volume from fslmerge (all subjects' COPEs concatenated)
- `var_cope_file`: The merged 4D VARCOPE volume from fslmerge (all subjects' VARCOPEs concatenated)
- `design_file`: Group-level design matrix
- `t_con_file`: Group-level contrast file
- `cov_split_file`: Group-level covariance structure (`.grp` file)
- `mask_file`: An MNI-space brain mask

flameo does **not** scatter — it receives pre-merged 4D volumes and performs group-level inference across all subjects in a single step.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 18 | fslmerge (COPEs) | `merged_image` | flameo | `cope_file` |
| 19 | fslmerge (VARCOPEs) | `merged_image` | flameo | `var_cope_file` |
| 20 | Input (`group_design`) | output | flameo | `design_file` |
| 21 | Input (`group_contrasts`) | output | flameo | `t_con_file` |
| 22 | Input (`group_covariance`) | output | flameo | `cov_split_file` |
| 23 | Input (`MNI_mask`) | output | flameo | `mask_file` |

Wire the `group_design`, `group_contrasts`, `group_covariance`, and `MNI_mask` Input nodes to flameo.

**Group-level design for a one-sample t-test (group mean activation):**

For 26 subjects, the design matrix is simply a column of ones:

```
/NumWaves 1
/NumPoints 26
/Matrix
1
1
1
... (26 rows)
```

**Group contrast:**
```
/NumWaves 1
/NumContrasts 1
/Matrix
1
```

**Covariance structure (`.grp` file):**
```
/NumWaves 1
/NumPoints 26
/Matrix
1
1
1
... (26 rows)
```

flameo produces group-level t-statistic and z-statistic maps. The z-statistic map is what you threshold and visualize.

---

> **Scatter propagation:** Because the BIDS node has scatter enabled, scatter automatically propagates downstream through all connected nodes from BET through film_gls. Each subject is preprocessed and analyzed independently. At the fslmerge step, the per-subject COPEs and VARCOPEs are flattened and concatenated into 4D volumes that flameo uses for group analysis.

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

## Step 14: Run the Workflow

Unzip the bundle and edit the job file before running.

### Edit the job template

Open `workflows/flanker_pipeline_job.yml`. Replace placeholder paths with actual paths on your system:

```yaml
# BIDS-resolved inputs (filled by resolve_bids.py or manually)
bold:
  - class: File
    path: /data/sub-01/func/sub-01_task-flanker_run-1_bold.nii.gz
  - class: File
    path: /data/sub-02/func/sub-02_task-flanker_run-1_bold.nii.gz
  # ... one per subject
t1w:
  - class: File
    path: /data/sub-01/anat/sub-01_T1w.nii.gz
  - class: File
    path: /data/sub-02/anat/sub-02_T1w.nii.gz
  # ... one per subject

# MNI template and mask
fnirt_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz
applywarp_reference:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm.nii.gz
flameo_mask_file:
  class: File
  path: /data/additional_inputs/MNI152_T1_2mm_brain_mask.nii.gz

# Per-subject first-level design files (one per subject, same order as bold)
film_gls_design_file:
  - class: File
    path: /data/additional_inputs/designs/sub-01_design.mat
  - class: File
    path: /data/additional_inputs/designs/sub-02_design.mat
  # ... one per subject
film_gls_contrast_file:
  class: File
  path: /data/additional_inputs/first_level_design.con

# Group-level design files
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
cwltool workflows/flanker_pipeline.cwl workflows/flanker_pipeline_job.yml
```

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

### First-level (film_gls) — per subject

film_gls produces a results directory (named `stats` per the configuration above) for each subject:

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
| `all_copes.nii.gz` | 4D volume containing all 26 subjects' COPE maps |
| `all_varcopes.nii.gz` | 4D volume containing all 26 subjects' VARCOPE maps |

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

- **Anterior cingulate cortex (ACC)** — conflict monitoring
- **Dorsolateral prefrontal cortex (DLPFC)** — cognitive control
- **Pre-supplementary motor area (pre-SMA)** — response selection
- **Inferior frontal junction** — attentional control

Compare your results against Kelly et al. (2008) Figure 3 and published Flanker meta-analyses.

You can view these maps overlaid on the MNI152 template in FSLeyes, MRIcroGL, or any NIfTI viewer.

---

## Tips

**Multi-subject processing with scatter:**
Because BIDS outputs are arrays (one file per subject), scatter automatically parallelizes the entire pipeline across subjects. Each subject is processed independently through the full preprocessing and first-level chain. At the fslmerge step, the per-subject COPEs and VARCOPEs are flattened from nested arrays (`File[][]`) into flat arrays (`File[]`), then concatenated into 4D volumes for flameo.

**Per-subject design matrices:**
Because ds000102 uses pseudorandom trial ordering, each subject's events.tsv has different onset times for congruent and incongruent conditions. The workflow scatters film_gls on both `input` and `design_file` using dotproduct, so the i-th BOLD file is always paired with the i-th design matrix. Ensure the `bold` and `film_gls_design_file` arrays are in the same subject order.

**Single first-level contrast:**
Use a single contrast (incongruent > congruent) in the first-level design. With one contrast, each subject produces exactly one COPE and one VARCOPE. The fslmerge flattening step (`self.flat()`) then yields a clean array of 26 files — one per subject. Multiple contrasts would require separating COPEs by contrast index before merging, which adds complexity.

**Save as a custom workflow:**
To reuse this pipeline in other projects, type a name in the **Name** field (top bar) and click **Save Workflow**. The pipeline appears under **My Workflows** in the left menu and can be dragged onto any future canvas as a single composite node.

**Use the CWL Preview panel:**
Before exporting, open the CWL Preview panel to inspect the generated CWL and job YAML in real time. This helps catch wiring mistakes or missing parameters before you download the bundle.

**Alternative: FEAT for integrated analysis:**
If you prefer FSL's integrated FEAT pipeline (which combines preprocessing and statistics in a single step), drag the **feat** node instead. It requires a pre-configured `.fsf` design file and the BOLD input. This is simpler but less modular than the step-by-step approach shown here.

**Temporal filtering:**
This tutorial does not include an explicit high-pass filtering step. If you need explicit high-pass filtering, add an **fslmaths** node between applywarp and film_gls and use the `-bptf` flag with the appropriate sigma value:

```
sigma = 1 / (2 × cutoff_frequency × TR)
```

For a 100s cutoff with TR = 2s: `sigma = 1 / (2 × 0.01 × 2) = 25`.

**Motion QC:**
Before proceeding to statistics, inspect the motion parameter plots from MCFLIRT. Consider excluding subjects with excessive motion (e.g., > 3mm translation or > 3° rotation). In a production pipeline, you would add a QC step here — niBuild includes MRIQC as a single-node option for automated quality assessment.
