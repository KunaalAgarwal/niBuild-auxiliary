# Pipelines

Complete multi-step analysis pipelines that chain several operations internally. Each tool orchestrates preprocessing, registration, segmentation, or analysis stages as a single command.

## FSL

Docker image: `brainlife/fsl`

### Structural

| Tool | Description |
|---|---|
| [FSL Anatomical Processing Pipeline](../structural-mri/fsl_anat.md) | Comprehensive automated pipeline for structural T1 processing including reorientation, cropping, bias correction, reg... |
| [Structural Image Evaluation using Normalisation of Atrophy (SIENA)](../structural-mri/siena.md) | Multi-step pipeline that estimates percentage brain volume change between two timepoints. Internally chains BET brain... |
| [SIENA Cross-Sectional (SIENAX)](../structural-mri/sienax.md) | Multi-step pipeline for cross-sectional brain volume estimation. Internally chains BET brain extraction, atlas regist... |
| [FMRIB's Integrated Registration and Segmentation Tool (FIRST)](../structural-mri/run_first_all.md) | Multi-step pipeline for subcortical structure segmentation. Internally chains registration, boundary correction, and ... |

### Functional

| Tool | Description |
|---|---|
| [FMRI Expert Analysis Tool (FEAT)](../functional-mri/feat.md) | Complete fMRI analysis pipeline combining preprocessing (motion correction, spatial smoothing, temporal filtering), f... |
| [Multivariate Exploratory Linear Optimized Decomposition into Independent Components (MELODIC)](../functional-mri/melodic.md) | Multi-step ICA pipeline that decomposes fMRI data into spatially independent components. Internally chains brain mask... |
| [FSL Dual Regression](../functional-mri/dual_regression.md) | Multi-step pipeline that projects group-level ICA spatial maps back to individual subjects. Internally chains spatial... |

### Diffusion

| Tool | Description |
|---|---|
| [Bayesian Estimation of Diffusion Parameters Obtained using Sampling Techniques (BEDPOSTX)](../diffusion-mri/bedpostx.md) | Multi-step pipeline for Bayesian estimation of fiber orientation distributions. Internally runs multi-fiber MCMC samp... |

### ASL

| Tool | Description |
|---|---|
| [Oxford ASL Processing Pipeline](../arterial-spin-labeling/oxford_asl.md) | Multi-step pipeline for ASL MRI quantification. Internally chains motion correction, registration, BASIL kinetic mode... |

## ANTs

Docker image: `antsx/ants`

### Structural

| Tool | Description |
|---|---|
| [ANTs Cortical Thickness Pipeline](../structural-mri/antsCorticalThickness_sh.md) | Complete automated pipeline for cortical thickness estimation using DiReCT, including brain extraction, segmentation,... |
| [ANTs Combined Atropos with N4 Bias Correction](../structural-mri/antsAtroposN4_sh.md) | Iteratively combines N4 bias field correction with Atropos segmentation for improved results on biased images. |

## FreeSurfer

Docker image: `freesurfer/freesurfer`

### Surface Reconstruction

| Tool | Description |
|---|---|
| [FreeSurfer Complete Cortical Reconstruction Pipeline](../structural-mri/recon-all.md) | Fully automated pipeline for cortical surface reconstruction and parcellation, including skull stripping, segmentatio... |

## fMRIPrep

Docker image: `nipreps/fmriprep`

### fMRI Preprocessing

| Tool | Description |
|---|---|
| [fMRIPrep: Robust fMRI Preprocessing Pipeline](../functional-mri/fmriprep.md) | Automated, robust preprocessing pipeline for task-based and resting-state fMRI, combining tools from FSL, FreeSurfer,... |

## MRIQC

Docker image: `nipreps/mriqc`

### Quality Control

| Tool | Description |
|---|---|
| [MRIQC: MRI Quality Control Pipeline](../functional-mri/mriqc.md) | Multi-step quality control pipeline. Internally chains brain extraction, spatial normalization, and computation of do... |

## ICA-AROMA

Docker image: `rtrhd/ica-aroma`

### Denoising

| Tool | Description |
|---|---|
| [ICA-based Automatic Removal of Motion Artifacts (ICA-AROMA)](../functional-mri/ICA_AROMA.md) | Multi-step denoising pipeline for fMRI motion artifact removal. Internally chains MELODIC ICA decomposition, motion a... |
