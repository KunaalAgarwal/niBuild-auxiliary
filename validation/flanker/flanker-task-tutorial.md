# Flanker Task Analysis: End-to-End Tutorial

This tutorial walks through building a complete fMRI analysis pipeline for the Eriksen flanker task using niBuild. By the end, you will have a portable, reproducible workflow bundle that preprocesses BOLD data, registers it to standard (MNI) space, runs a first-level GLM for each subject, and combines results across subjects in a group-level analysis — all exported as a self-contained RO-Crate.

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

The workflow chains eight FSL tools into a complete preprocessing → registration → statistics pipeline:

```
BIDS Dataset
  ├─ t1w ──> BET ──────────────────────────────────────> FLIRT (reference)
  │            └──────────────────────────────────────────> FNIRT (input)
  │                                                            │
  └─ bold ─> MCFLIRT ─> slicetimer ─> SUSAN ──────> FLIRT ─> applywarp ─> film_gls ─> flameo
                                                       │                      ↑           ↑
                                               MNI152 ─┤─> FNIRT (ref)   design.mat     design.mat
                                                       │                 contrasts.con   contrasts.con
                                                       └─> applywarp (ref)
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
| 9 | flameo | Group-level mixed-effects analysis across subjects |

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
| `design_matrix` | First-level GLM design matrix | Custom `.mat` file (see Step 9) |
| `contrasts` | First-level contrast definitions | Custom `.con` file (see Step 9) |
| `group_design` | Group-level design matrix | Simple one-column design (see Step 10) |
| `group_contrasts` | Group-level contrasts | Simple mean contrast (see Step 10) |
| `group_covariance` | Group-level covariance structure | `.grp` file (see Step 10) |

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

---

## Step 4: Preprocessing — Functional Data

### MCFLIRT (Motion Correction)

Drag **mcflirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_mc` | Output filename stem |
| `mean_vol` | `true` | Register all volumes to the mean (robust for long runs) |
| `save_plots` | `true` | Save motion parameter plots for QC |

### slicetimer (Slice Timing Correction)

Drag **slicetimer** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `bold_st` | Output filename stem |
| `interleaved` | `true` | ds000102 uses interleaved acquisition |

> **Note:** Check your acquisition protocol. If unsure, inspect the `SliceTiming` field in the BOLD sidecar JSON (`sub-XX_task-flanker_bold.json`).

### SUSAN (Spatial Smoothing)

Drag **susan** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `brightness_threshold` | `2000` | ~10% of mean image intensity; above noise, below edge contrast |
| `fwhm` | `5` | 5 mm FWHM Gaussian kernel — standard for single-subject fMRI |
| `output` | `bold_smooth` | Output filename stem |

The defaults for `dimension` (3), `use_median` (1), and `n_usans` (0) are appropriate.

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

---

## Step 6: Registration — Structural to MNI

### FNIRT (Nonlinear Registration)

Drag **fnirt** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `struct2mni_warp` | Output warp field filename |
| `iout` | `struct2mni` | Warped output image filename |

FNIRT takes the skull-stripped T1w (from BET) as `input` and the MNI152 template (from the Input node) as `ref`. It produces a nonlinear warp field that maps structural space to MNI space.

> **Note:** FNIRT expects an affine initialization. If needed, run a 12-DOF FLIRT (structural → MNI) first and provide the resulting matrix via FNIRT's `aff` parameter. For many datasets, FNIRT's internal initialization is sufficient.

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
- `ref`: MNI152 template
- `warp`: Warp field from FNIRT
- `premat`: Transformation matrix from FLIRT (`func2struct.mat`)

This brings all subjects' functional data into the same standard space, which is required for group-level analysis.

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

1. **Design matrix** (`.mat` file) — encodes the GLM regressors
2. **Contrast file** (`.con` file) — defines the contrasts of interest

Wire the `design_matrix` and `contrasts` Input nodes to film_gls.

film_gls produces per-subject COPEs (contrast of parameter estimates), VARCOPEs (variance estimates), and t/z-statistic maps. Because scatter is active, this runs independently for each subject.

---

## Step 9: Preparing the First-Level Design

The first-level design matrix encodes the experimental conditions and confound regressors for each subject. For the flanker task:

**Regressors:**
1. Incongruent trials — onsets and durations convolved with a double-gamma HRF
2. Congruent trials — onsets and durations convolved with a double-gamma HRF
3–8. Six motion parameters from MCFLIRT (translation x/y/z, rotation x/y/z)

**Temporal derivative:** Optionally add temporal derivatives of the task regressors to capture HRF timing variability.

**High-pass filter:** Apply a high-pass filter cutoff of ~100s (encoded in the design matrix or via fslmaths `-bptf` before film_gls).

**Contrast (incongruent > congruent):**
```
/NumWaves 8
/NumContrasts 1
/Matrix
1 -1 0 0 0 0 0 0
```

This contrast tests for greater activation during incongruent relative to congruent trials — the core cognitive control contrast.

**Creating the design files:**

Option A: Use FSL's `Glm` GUI to design the matrix interactively.

Option B: Use `fsl_glm` or write the `.mat` and `.con` files by hand following FSL's format.

Option C: Use a script to generate subject-specific designs from the BIDS events.tsv files:

```python
# Pseudocode for generating design from BIDS events
import pandas as pd
import numpy as np

events = pd.read_csv('sub-01_task-flanker_events.tsv', sep='\t')
incongruent = events[events['trial_type'] == 'incongruent']
congruent = events[events['trial_type'] == 'congruent']

# Convolve onsets with HRF, sample at TR, combine with motion params
# Output as FSL .mat format
```

> **Note:** If all subjects share the same event timing (as in ds000102's slow event-related design), a single design matrix can be used across subjects. If timing varies, you will need per-subject designs — in that case, scatter over both the BOLD data and the design files.

---

## Step 10: Group-Level Statistics

### flameo (FMRIB's Local Analysis of Mixed Effects)

Drag **flameo** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `run_mode` | `flame1` | FLAME 1 mixed-effects model — standard for group fMRI |

flameo takes the following inputs:

- `cope`: The COPE images from film_gls (one per subject — the scatter output)
- `varcope`: The VARCOPE images from film_gls (one per subject)
- `design_file`: Group-level design matrix
- `t_contrast`: Group-level contrast file
- `covariance_file`: Group-level covariance structure (`.grp` file)
- `mask`: An MNI-space brain mask (e.g., from the MNI152 template or created with fslmaths)

Wire the `group_design`, `group_contrasts`, and `group_covariance` Input nodes to flameo.

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

## Step 11: Wire the Nodes

Connect nodes by dragging from an output port on one node to an input port on the next. When you create or double-click an edge, the **Edge Mapping Modal** opens showing source outputs on the left and target inputs on the right.

### Wiring sequence

Wire each connection in the following order. For each edge, click the source output name on the left, then click the matching target input name on the right, and click **Save**.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 1 | BIDS | `t1w` | BET | `input` |
| 2 | BIDS | `bold` | MCFLIRT | `input` |
| 3 | MCFLIRT | `motion_corrected` | slicetimer | `input` |
| 4 | slicetimer | `slice_time_corrected` | SUSAN | `input` |
| 5 | SUSAN | `smoothed_image` | FLIRT | `input` |
| 6 | BET | `brain_extraction` | FLIRT | `reference` |
| 7 | BET | `brain_extraction` | FNIRT | `input` |
| 8 | Input (`MNI152`) | output | FNIRT | `ref` |
| 9 | SUSAN | `smoothed_image` | applywarp | `input` |
| 10 | Input (`MNI152`) | output | applywarp | `ref` |
| 11 | FNIRT | `fieldcoeff_out` | applywarp | `warp` |
| 12 | FLIRT | `output_matrix_file` | applywarp | `premat` |
| 13 | applywarp | `output` | film_gls | `input` |
| 14 | Input (`design_matrix`) | output | film_gls | `design_file` |
| 15 | Input (`contrasts`) | output | film_gls | `contrast_file` |
| 16 | film_gls | `cope` | flameo | `cope` |
| 17 | film_gls | `varcope` | flameo | `varcope` |
| 18 | Input (`group_design`) | output | flameo | `design_file` |
| 19 | Input (`group_contrasts`) | output | flameo | `t_contrast` |
| 20 | Input (`group_covariance`) | output | flameo | `covariance_file` |

After wiring, your canvas should show an animated edge between every connected pair of nodes. Wired input ports on each node turn a different color from unwired ones, letting you visually verify that all required inputs are satisfied.

> **Scatter propagation:** Because the BIDS node has scatter enabled, scatter automatically propagates downstream through all connected nodes from BET through film_gls. Each subject is preprocessed and analyzed independently. At the flameo step, the per-subject COPEs and VARCOPEs are collected as arrays for group analysis.

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
  class: File
  path: /data/sub-01/func/sub-01_task-flanker_bold.nii.gz
t1w:
  class: File
  path: /data/sub-01/anat/sub-01_T1w.nii.gz

# MNI template
MNI152:
  class: File
  path: /usr/local/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz

# First-level design files
design_matrix:
  class: File
  path: /data/design/flanker_design.mat
contrasts:
  class: File
  path: /data/design/flanker_contrasts.con

# Group-level design files
group_design:
  class: File
  path: /data/design/group_design.mat
group_contrasts:
  class: File
  path: /data/design/group_contrasts.con
group_covariance:
  class: File
  path: /data/design/group_covariance.grp

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
| `pe1.nii.gz`, `pe2.nii.gz`, ... | Parameter estimate maps (one per regressor) |
| `cope1.nii.gz` | Contrast of parameter estimates (incongruent > congruent) |
| `varcope1.nii.gz` | Variance of the COPE |
| `tstat1.nii.gz` | T-statistic map |
| `zstat1.nii.gz` | Z-statistic map |
| `sigmasquareds.nii.gz` | Residual variance |
| `dof` | Degrees of freedom |

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
Because BIDS outputs are arrays (one file per subject), scatter automatically parallelizes the entire pipeline across subjects. Each subject is processed independently through the full preprocessing and first-level chain. At the group level, flameo receives the collected COPEs/VARCOPEs from all subjects.

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