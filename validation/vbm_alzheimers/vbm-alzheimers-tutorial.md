# End-to-End tutorial of VBM Analysis: Alzheimer's Gray Matter Differences

This tutorial walks through building a voxel-based morphometry (VBM) pipeline using niBuild to detect gray matter differences between cognitively normal controls and individuals with Alzheimer's-type dementia. Unlike the flanker fMRI tutorial (which uses BIDS-formatted input), this tutorial demonstrates how to use niBuild with **non-BIDS data** (providing input images directly as a file array). By the end, you will have a portable, reproducible workflow bundle that extracts the brain, segments tissue, registers to standard space, modulates gray matter maps, smooths, and runs non-parametric group-level statistics.

## Background

VBM is a whole-brain, voxelwise technique for detecting regional differences in tissue composition (typically gray matter) between groups. The standard FSL-VBM pipeline (Good et al., 2001; Douaud et al., 2007) is one of the most widely used structural analysis methods in neuroimaging.

Gray matter atrophy in Alzheimer's disease is among the most robust and well-characterized structural findings in clinical neuroimaging. Hippocampal volume loss is detectable even at the very mild dementia stage (CDR 0.5), with OASIS cross-sectional data showing statistically significant whole-brain volume differences between CDR 0 and CDR 0.5 groups (p < 0.01; Marcus et al., 2007). VBM meta-analyses consistently identify atrophy in medial temporal lobe structures (hippocampus, entorhinal cortex, amygdala), temporal neocortex, and posterior parietal regions (Li et al., 2021; Karas et al., 2004). This tutorial reproduces that consensus finding using the OASIS-1 cross-sectional dataset.

## Prerequisites

- A modern web browser (Chrome, Firefox, or Edge)
- Docker **or** Singularity/Apptainer installed on the machine where you will run the workflow
- The [OASIS-1](https://www.oasis-brains.org/) cross-sectional dataset: T1-weighted structural MRI scans with Clinical Dementia Rating (CDR) scores
- **Data preparation completed**: run `prepare_data.py` to convert Analyze images to NIfTI and generate design files (see the Data Preparation section below)

### Data Preparation

Before building the workflow, the raw OASIS-1 data must be prepared:

1. Download the OASIS-1 cross-sectional dataset (12 disc archives) from [oasis-brains.org](https://www.oasis-brains.org/).
2. Extract all disc archives into a `data/` directory.
3. Run the preparation script:

```bash
python prepare_data.py
```

This script:
- Converts Analyze (.hdr/.img) images to NIfTI (.nii.gz) format using nibabel
- Flattens subjects from disc1–12 into a single `data/nifti/` directory
- Filters subjects to those with CDR scores (excludes missing CDR and repeat MR2 scans)
- Generates FSL design matrix (`design.mat`) and contrast (`design.con`) files

**Resulting cohort:** 235 subjects — 135 controls (CDR = 0) and 100 demented (CDR >= 0.5: 70 very mild, 28 mild, 2 moderate). Mean age: 72.3 years (controls: 69.1, demented: 76.8). Covariates are age and sex.

## Pipeline Overview

The workflow chains seven FSL tools to implement the standard FSL-VBM pipeline:

```
Input (T1w file array)
  │
  └─> BET ─> FAST ─> FLIRT ─> FNIRT ─> fslmaths (modulation) ─> fslmaths (smoothing) ─> fslmerge
                                                                                            │
      Input (design.mat) ──────────────────────────────────────────────────────────> randomise
      Input (design.con) ──────────────────────────────────────────────────────────>
      Input (mask) ────────────────────────────────────────────────────────────────>
```

| Step | Tool | Purpose |
|------|------|---------|
| 1 | BET | Skull-strip the T1w structural image |
| 2 | FAST | Segment brain tissue into gray matter, white matter, and CSF |
| 3 | FLIRT | Affine registration of gray matter to MNI152 |
| 4 | FNIRT | Non-linear registration to MNI152 for accurate normalization |
| 5 | fslmaths | Jacobian modulation of gray matter maps to preserve volume information |
| 6 | fslmaths | Spatial smoothing of modulated gray matter maps |
| 7 | fslmerge | Concatenate all subjects into a single 4D image |
| 8 | randomise | Non-parametric permutation testing for group comparisons |

> **Note:** In a full FSL-VBM protocol, an intermediate step creates a study-specific template by averaging all subjects' registered gray matter maps. That template-creation step is typically done offline (using fslmerge + fslmaths to average, then re-registering all subjects to the average). This tutorial assumes you are registering directly to the MNI152 gray matter template. A note at the end describes how to build the study-specific template.

---

## Step 1: Load Input Data (Non-BIDS)

Unlike the schizophrenia tutorial which uses a BIDS loader, this tutorial demonstrates niBuild's direct file input approach which is useful for older datasets that are not organized in BIDS format.

1. Open niBuild in your browser.
2. In the left-hand tool menu, expand the **I/O** section at the top.
3. Drag an **Input** node onto the canvas. Double-click to open its configuration.
4. Set the label to `t1w`.

When you export and run the workflow, you will populate this input in the job YAML file with the paths to your NIfTI images:

```yaml
t1w:
  - class: File
    path: /path/to/data/nifti/OAS1_0001_MR1.nii.gz
  - class: File
    path: /path/to/data/nifti/OAS1_0002_MR1.nii.gz
  # ... one entry per subject (235 total)
```

> **Tip:** You can generate this YAML list programmatically. For example:
> ```bash
> for f in data/nifti/*.nii.gz; do echo "  - class: File"; echo "    path: $f"; done
> ```

---

## Step 2: Add Brain Extraction

Drag **bet** from **Structural MRI > FSL > Bet (Brain Extraction)** onto the canvas. Double-click the node to open its parameter modal and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `brain` | Output filename stem |
| `frac` | `0.3` | Lower threshold than default (0.5) to ensure no gray matter is removed; VBM is sensitive to incomplete extraction |
| `mask` | `true` | Generate a binary brain mask for later use |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 1 | Input (`t1w`) | output | BET | `input` |

In the BET parameter modal set the `input` parameter to scatter via pressing the circular arrow symbol. This allows for the array of inputs to efficiently be processed by the workflow.

> **Tip:** For VBM, it is better to err on the side of a slightly liberal extraction. Residual non-brain tissue will be classified as non-GM by FAST, but missing gray matter cannot be recovered.

---

## Step 3: Add Tissue Segmentation

Drag **fast** from **Structural MRI > FSL > Fast (Tissue Segmentation)** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `tissue` | Output filename prefix |
| `nclass` | `3` | Standard three-class segmentation: gray matter, white matter, CSF |
| `image_type` | `1` | T1-weighted input (1 = T1) |
| `segments` | `true` | Output separate binary segmentation files for each tissue type |
| `bias_corrected_image` | `true` | Output the bias-corrected image (useful for QC) |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 2 | BET | `brain_extraction` | FAST | `input` |

FAST produces partial volume estimate (PVE) maps for each tissue class. The gray matter PVE map (`tissue_pve_1.nii.gz` by convention — FAST labels GM as class 1) is the key output for VBM.

---

## Step 4: Add Registration to Standard Space

### FLIRT (Affine Registration)

Drag **flirt** from **Structural MRI > FSL > Flirt (Registration)** onto the canvas. Also drag an **Input** node from the I/O section — this will provide the MNI152 standard-space template.

Double-click the Input node and set its label to `MNI152_template`.

Double-click the FLIRT node and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `gm_affine` | Output filename stem |
| `dof` | `12` | 12-DOF affine registration — standard for structural-to-standard |
| `output_matrix` | `struct2mni_affine.mat` | Save the affine matrix for FNIRT initialization |
| `cost` | `corratio` | Correlation ratio — robust for T1-to-T1 registration |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 3 | FAST | `segmented_files` | FLIRT | `input` |
| 4 | Input (`MNI152_template`) | output | FLIRT | `reference` |

- FAST outputs `segmented_files` as a File array containing the PVE maps. In the edge mapping modal, map this to FLIRT's `input`. The gray matter PVE (typically `_pve_1`) is the file of interest. Thus you need to add an expression for the FLIRT input parameter. Open the FLIRT parameter modal, locate the `input` parameter, press the expression (f(x)) button, and paste the following: `self.filter(function(f) { return f.basename.indexOf('pve_1') !== -1; })[0]`, finally press save.
 
### FNIRT (Non-linear Registration)

Drag **fnirt** from **Structural MRI > FSL > Registration** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `config` | *(see below)* | FSL-tuned configuration for T1-to-MNI registration |
| `iout` | `gm_nonlinear` | Output warped image filename |
| `cout` | `struct2mni_warp` | Output warp coefficients (needed for applywarp) |
| `jout` | `jacobian` | Output Jacobian determinant map — needed for modulation |

> **Important — FNIRT config file:** FNIRT's default parameters are generic and can produce poorly regularized warp fields (extreme Jacobian values including negative determinants, which indicate warp folding). FSL ships a config file tuned specifically for T1-to-MNI152 registration that sets appropriate subsampling schedules, warp resolution, smoothing kernels, and regularization strength. You must extract this file from the FSL Docker image and provide it as an input:
>
> ```bash
> docker run --rm brainlife/fsl:6.0.4-patched2 \
>   cat /usr/local/fsl/etc/flirtsch/T1_2_MNI152_2mm.cnf \
>   > additional_inputs/T1_2_MNI152_2mm.cnf
> ```
>
> Then drag an **Input** node onto the canvas, label it `fnirt_config`, and wire it to FNIRT's `config` input. In your job YAML, set:
>
> ```yaml
> fnirt_config:
>   class: File
>   path: /path/to/additional_inputs/T1_2_MNI152_2mm.cnf
> ```

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 5 | FLIRT | `transformation_matrix` | FNIRT | `affine` |
| 6 | BET | `brain_extraction` | FNIRT | `input` |
| 7 | Input (`MNI152_template`) | output | FNIRT | `reference` |
| 8 | Input (`fnirt_config`) | output | FNIRT | `config` |

The `affine` input will receive the affine matrix from FLIRT, and `reference` will receive the MNI152 template. This initializes FNIRT with the affine solution for faster convergence. The `config` input provides the `T1_2_MNI152_2mm.cnf` file which constrains FNIRT's optimization to produce well-behaved warp fields suitable for VBM.

---

## Step 5: Add Jacobian Modulation

After non-linear registration, gray matter maps must be modulated by the Jacobian determinant of the warp field. This corrects for local volume changes introduced by the registration — without modulation, VBM would detect shape differences rather than volume differences.

Drag **fslmaths** from **Utilities > FSL > Image Math** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `gm_modulated` | Output filename |
| `mul_file` | *(wired from FNIRT)* | Multiply gray matter by the Jacobian map |

This node will receive the registered gray matter map as its `input` and the Jacobian map from FNIRT as its `mul_file` (Multiply by image).

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 9 | FLIRT | `registered_image` | fslmaths (modulation) | `input` |
| 10 | FNIRT | `jacobian_map` | fslmaths (modulation) | `mul_file` |

---

## Step 6: Add Spatial Smoothing

Smoothing is essential in VBM to account for residual registration inaccuracies and to satisfy the assumptions of random field theory (used for multiple comparisons correction in some approaches).

Drag a second **fslmaths** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `gm_smooth` | Output filename |
| `s` | `3` | Gaussian smoothing with sigma = 3 mm (equivalent to ~7 mm FWHM, which is standard for VBM; FWHM = sigma * 2.355) |

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 11 | fslmaths (modulation) | `output_image` | fslmaths (smoothing) | `input` |

---

## Step 7: Merge Subjects into a 4D Image

Because scatter processes each subject independently, the smoothed outputs must be gathered into a single 4D image before group statistics.

Drag **fslmerge** from **Utilities > FSL > Image Utilities** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `all_GM_smooth` | Output filename for the merged 4D stack |
| `dimension` | `t` | Concatenate along the time (4th) dimension — one 3D volume per subject |

This node gathers the scattered per-subject smoothed images into a single 4D file for randomise.

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 12 | fslmaths (smoothing) | `output_image` | fslmerge | `input_files` |

---

## Step 8: Add Group-Level Statistics

Drag **randomise** from **Functional MRI > FSL > Statistical Analysis** onto the canvas. Double-click and set:

| Parameter | Value | Why |
|-----------|-------|-----|
| `output` | `vbm_results` | Output root name for all result files |
| `num_perm` | `5000` | Number of permutations (5000 is standard for publication-quality results) |
| `tfce` | `true` | Threshold-Free Cluster Enhancement — recommended over arbitrary cluster-forming thresholds |
| `demean` | `true` | Demean the data before analysis |

**randomise requires three external files** that encode your group design:

1. **Design matrix** (`design.mat`) — a 4-column VEST-format matrix with columns: CONTROL indicator, AD indicator, demeaned age, demeaned sex. Generated by `prepare_data.py`.

2. **T-contrast file** (`design.con`) — defines two contrasts:
   - Contrast 1: controls > demented (1, -1, 0, 0) — tests for gray matter reduction in dementia
   - Contrast 2: demented > controls (-1, 1, 0, 0) — tests for gray matter increase in dementia

3. **Mask** — a binary mask restricting the analysis to a common brain region (typically the MNI152 brain mask or a thresholded mean gray matter image).

Drag three **Input** nodes from the I/O section onto the canvas. Double-click each to set their labels:
- First Input: `design_matrix`
- Second Input: `contrasts`
- Third Input: `gm_mask`

| # | Source node | Source output | Target node | Target input |
|---|-------------|---------------|-------------|--------------|
| 13 | fslmerge | `merged_image` | randomise | `input` |
| 14 | Input (`design_matrix`) | output | randomise | `design_mat` |
| 15 | Input (`contrasts`) | output | randomise | `tcon` |
| 16 | Input (`gm_mask`) | output | randomise | `mask` |

---

**Additional notes**

- **Rows 9–10:** The modulation fslmaths node multiplies the affine-registered gray matter map (from FLIRT) by the Jacobian determinant (from FNIRT). This preserves volume information that would otherwise be lost during registration.

- **Rows 12–13:** The scattered per-subject smoothed images feed into fslmerge, which gathers them into a single 4D stack. randomise then operates on this 4D image.

> **Scatter propagation:** Because the `t1w` Input provides a file array, scatter automatically propagates through BET, FAST, FLIRT, FNIRT, and both fslmaths nodes. Each subject is processed independently. fslmerge gathers the scattered outputs into a single 4D image for randomise.

---

## Step 10: Pin Docker Versions

For reproducibility, pin a specific FSL version rather than using `latest`.

1. Double-click any FSL node (e.g., BET).
2. In the parameter modal, find the **Docker version** dropdown.
3. Select a version such as `6.0.5` or `6.0.4-patched2`.
4. Repeat for each FSL node, or set them all to the same version.

All FSL tools use the `brainlife/fsl` Docker image. If you select different versions on different nodes, niBuild will warn you about the conflict during export.

---

## Step 11: Name and Export

1. In the top bar, set the **Output** name to `vbm_alzheimers` (or any name you prefer).
2. Click the **Generate Workflow** button in the actions bar.
3. Your browser downloads `vbm_alzheimers.crate.zip`.

The ZIP contains:

```
vbm_alzheimers.crate.zip/
├── workflows/
│   ├── vbm_alzheimers.cwl          # Main CWL workflow
│   └── vbm_alzheimers_job.yml      # Job template with your parameter values
├── cwl/
│   └── fsl/
│       ├── bet.cwl
│       ├── fast.cwl
│       ├── flirt.cwl
│       ├── fnirt.cwl
│       ├── fslmaths.cwl
│       ├── fslmerge.cwl
│       └── randomise.cwl
├── Dockerfile
├── run.sh
├── prefetch_images.sh
├── Singularity.def
├── run_singularity.sh
├── prefetch_images_singularity.sh
├── ro-crate-metadata.json
└── README.md
```

---

## Step 12: Run the Workflow

Unzip the bundle and edit the job file before running.

### Edit the job template

Open `workflows/vbm_alzheimers_job.yml`. Replace placeholder paths with actual paths on your system:

```yaml
# T1w input images — one entry per subject (235 total)
t1w:
  - class: File
    path: /path/to/data/nifti/OAS1_0001_MR1.nii.gz
  - class: File
    path: /path/to/data/nifti/OAS1_0002_MR1.nii.gz
  # ... all 235 subjects

# Standard space template
flirt_reference:
  class: File
  path: /path/to/additional_inputs/MNI152_T1_2mm.nii.gz
fnirt_reference:
  class: File
  path: /path/to/additional_inputs/MNI152_T1_2mm.nii.gz

# FNIRT config (extracted from FSL Docker image)
fnirt_config:
  class: File
  path: /path/to/additional_inputs/T1_2_MNI152_2mm.cnf

# Group design files (generated by prepare_data.py)
randomise_design_mat:
  class: File
  path: /path/to/additional_inputs/design.mat
randomise_tcon:
  class: File
  path: /path/to/additional_inputs/design.con
randomise_mask:
  class: File
  path: /path/to/additional_inputs/MNI152_T1_2mm_brain_mask.nii.gz

# Tool parameters (pre-filled from your canvas configuration)
bet_output: brain
bet_frac: 0.3
fast_output: tissue
fast_nclass: 3
# ... remaining parameters
```

You can generate the `t1w` file list programmatically:

```bash
echo "t1w:" > t1w_list.yml
for f in /path/to/data/nifti/OAS1_*_MR1.nii.gz; do
  echo "  - class: File" >> t1w_list.yml
  echo "    path: $f" >> t1w_list.yml
done
```

> **Important:** The order of subjects in the `t1w` array must match the row order in `design.mat`. The `prepare_data.py` script sorts subjects alphabetically by ID, so sort your file list the same way (the glob above does this naturally).

### Option A: Run with Docker

```bash
cd vbm_alzheimers

# Optional: pre-pull FSL images
bash prefetch_images.sh

# Build the orchestration container
docker build -t vbm-pipeline .

# Run
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/data:/data \
  -v /path/to/output:/output \
  vbm-pipeline
```

The `-v /var/run/docker.sock:/var/run/docker.sock` mount is required because cwltool inside the container launches per-tool Docker containers (Docker-in-Docker pattern).

### Option B: Run with cwltool directly

```bash
pip install cwltool
cd vbm_alzheimers
cwltool --parallel --cachedir cache \
  workflows/vbm_alzheimers.cwl workflows/vbm_alzheimers_job.yml
```

> **Note:** `--parallel` enables concurrent execution of scattered subjects — without it, cwltool processes each subject sequentially even when scatter is specified. `--cachedir cache` caches completed step outputs so that if the workflow is interrupted, re-running it skips already-finished jobs.

### Option C: Run with Singularity (HPC)

```bash
cd vbm_alzheimers

# Convert Docker images to SIF
bash prefetch_images_singularity.sh

# Build the orchestration container
singularity build vbm-pipeline.sif Singularity.def

# Run
singularity run \
  --bind /path/to/data:/data \
  --bind /path/to/output:/output \
  vbm-pipeline.sif
```

> **Note:** VBM with 235 subjects and 5000 permutations is computationally intensive. On an HPC cluster with Singularity, consider requesting sufficient memory (8+ GB per subject for FNIRT) and using the cluster's job scheduler to parallelize subjects.

---

## Expected Outputs

randomise produces several output files for each contrast:

| File | Description |
|------|-------------|
| `vbm_results_tstat1.nii.gz` | T-statistic map for contrast 1 (controls > demented) |
| `vbm_results_tstat2.nii.gz` | T-statistic map for contrast 2 (demented > controls) |
| `vbm_results_tfce_corrp_tstat1.nii.gz` | TFCE-corrected p-values for contrast 1 (1 - p) |
| `vbm_results_tfce_corrp_tstat2.nii.gz` | TFCE-corrected p-values for contrast 2 (1 - p) |
| `vbm_results_tfce_p_tstat1.nii.gz` | Uncorrected TFCE p-values for contrast 1 |
| `vbm_results_tfce_p_tstat2.nii.gz` | Uncorrected TFCE p-values for contrast 2 |

**What to look for:** The corrected p-value maps (`_tfce_corrp_tstat1`) show regions where gray matter volume significantly differs between groups after multiple comparisons correction. Threshold these at 0.95 (corresponding to p < 0.05 corrected, since the maps encode 1 - p).

For the controls > demented contrast, the literature predicts significant gray matter reduction clusters (p < 0.05, TFCE-corrected) localized to:

- **Medial temporal lobe:** Hippocampus, entorhinal cortex, parahippocampal gyrus — the earliest and most robust sites of Alzheimer's-related atrophy
- **Temporal neocortex:** Middle and inferior temporal gyri, fusiform gyrus
- **Limbic structures:** Amygdala, posterior cingulate cortex
- **Parietal cortex:** Precuneus, inferior parietal lobule

These regions are consistent with Braak staging of Alzheimer's neuropathology and the atrophy patterns documented in large-scale VBM studies (Karas et al., 2004; Whitwell et al., 2007) and the OASIS dataset analyses (Marcus et al., 2007).

You can view these maps in FSLeyes, MRIcroGL, or any NIfTI viewer by overlaying the `_tfce_corrp_tstat1` map on the MNI152 template and thresholding at 0.95.

---

## Tips

**Non-BIDS vs. BIDS workflow:**
This tutorial demonstrates that niBuild workflows are not limited to BIDS-formatted data. Any collection of NIfTI images can be used as input by providing them as a file array through an Input node. The key requirement is that the order of files in the array matches the row order in the design matrix.

**Study-specific template creation:**
The full FSL-VBM protocol creates a study-specific template rather than registering directly to MNI152. To do this:
1. Run the pipeline through the FLIRT step for all subjects (affine registration to MNI).
2. Use **fslmerge** (set `dimension: t`) to concatenate all affine-registered GM maps into a 4D stack.
3. Use **fslmaths** with `Tmean: true` to average the 4D stack into a single mean GM template.
4. Use this mean template as the `reference` for FNIRT in a second pass, re-running FNIRT + modulation + smoothing against the study-specific template.

This two-pass approach improves registration quality by reducing bias toward the MNI template shape.

**Controlling for covariates:**
The design matrix generated by `prepare_data.py` includes demeaned age and sex as covariates. Additional covariates such as estimated total intracranial volume (eTIV, available in `oasis_cross-sectional.csv`) or education level can be added by modifying `prepare_data.py` to include extra columns.

**CDR subgroup analyses:**
The default analysis groups all CDR >= 0.5 subjects together. For more targeted analyses, you can modify `prepare_data.py` to compare:
- CDR 0 vs. CDR 0.5 only — to detect the earliest structural changes
- CDR 0 vs. CDR 1+ — to maximize effect size with clinically demented subjects
- Three-group F-test (CDR 0 vs. 0.5 vs. 1+) — to test for a dose-response relationship with dementia severity

**Multi-subject processing with scatter:**
Because the `t1w` Input is a file array, scatter automatically parallelizes the per-subject preprocessing chain. The critical step is gathering at fslmerge — this is where individual subject maps become a single 4D group image for randomise.

**Save as a custom workflow:**
To reuse this VBM pipeline in other projects, type a name in the **Name** field (top bar) and click **Save Workflow**. The pipeline appears under **My Workflows** in the left menu and can be dragged onto any future canvas as a single composite node.

**Use the CWL Preview panel:**
Before exporting, open the CWL Preview panel to inspect the generated CWL and job YAML in real time. This helps catch wiring mistakes or missing parameters before you download the bundle.

**Alternative: fsl_anat for preprocessing:**
If you prefer an integrated structural preprocessing step, drag the **fsl_anat** node instead of separate BET + FAST steps. fsl_anat performs reorientation, cropping, bias correction, brain extraction, and tissue segmentation in a single operation. You would then wire its outputs to the registration steps.
