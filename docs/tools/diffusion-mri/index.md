# Diffusion MRI

Diffusion-weighted imaging for white matter microstructure. Used for eddy current correction, tensor fitting, tractography, and connectivity analysis.

## FSL

Docker image: `brainlife/fsl`

### Preprocessing

| Tool | Description |
|---|---|
| [FSL Eddy Current and Motion Correction (eddy)](eddy.md) | Corrects eddy current-induced distortions and subject movement in diffusion MRI data using a Gaussian process model. |
| [Tool for Estimating and Correcting Susceptibility-Induced Distortions (TOPUP)](../functional-mri/topup.md) | Estimates and corrects susceptibility-induced distortions using pairs of images with reversed phase-encode directions. |

### Tensor Fitting

| Tool | Description |
|---|---|
| [FSL Diffusion Tensor Fitting (dtifit)](dtifit.md) | Fits a diffusion tensor model to each voxel of preprocessed diffusion-weighted data to generate scalar diffusion maps. |

### Tractography

| Tool | Description |
|---|---|
| [Bayesian Estimation of Diffusion Parameters Obtained using Sampling Techniques (BEDPOSTX)](bedpostx.md) | Multi-step pipeline for Bayesian estimation of fiber orientation distributions. Internally runs multi-fiber MCMC samp... |
| [Probabilistic Tractography with Crossing Fibres (probtrackx2)](probtrackx2.md) | Probabilistic tractography using fiber orientation distributions from bedpostx to trace white matter pathways. |

### TBSS

| Tool | Description |
|---|---|
| [TBSS Step 1: Preprocessing](tbss_1_preproc.md) | Preprocesses FA images for TBSS by slightly eroding them and zeroing end slices to remove outlier voxels. |
| [TBSS Step 2: Registration](tbss_2_reg.md) | Registers all FA images to a target (best subject or standard-space template) using non-linear registration. |
| [TBSS Step 3: Post-Registration](tbss_3_postreg.md) | Creates mean FA image and FA skeleton by projecting registered FA data onto a mean tract center. |
| [TBSS Step 4: Pre-Statistics](tbss_4_prestats.md) | Projects all subjects FA data onto the mean FA skeleton, ready for voxelwise cross-subject statistics. |
| [TBSS Non-FA Image Projection](tbss_non_FA.md) | Projects non-FA diffusion images (MD, AD, RD, etc.) onto the mean FA skeleton using the same registration from the FA... |

## MRtrix3

Docker image: `mrtrix3/mrtrix3`

### Preprocessing

| Tool | Description |
|---|---|
| [MRtrix3 DWI Denoising (MP-PCA)](dwidenoise.md) | Removes thermal noise from diffusion MRI data using Marchenko-Pastur PCA exploiting data redundancy across diffusion ... |
| [MRtrix3 Gibbs Ringing Removal](mrdegibbs.md) | Removes Gibbs ringing artifacts (truncation artifacts) from MRI data using a local subvoxel-shift method. |

### Tensor/FOD

| Tool | Description |
|---|---|
| [MRtrix3 Diffusion Tensor Estimation](dwi2tensor.md) | Estimates the diffusion tensor model at each voxel from preprocessed DWI data using weighted or ordinary least squares. |
| [MRtrix3 Tensor Metric Extraction](tensor2metric.md) | Extracts scalar metrics (FA, MD, AD, RD, eigenvalues, eigenvectors) from a fitted diffusion tensor image. |
| [MRtrix3 Fiber Orientation Distribution Estimation](dwi2fod.md) | Estimates fiber orientation distributions (FODs) using constrained spherical deconvolution to resolve crossing fibers. |

### Tractography

| Tool | Description |
|---|---|
| [MRtrix3 Streamline Tractography Generation](tckgen.md) | Generates streamline tractograms using various algorithms (iFOD2, FACT, etc.) from FOD or tensor images. |
| [MRtrix3 SIFT Tractogram Filtering](tcksift.md) | Filters tractograms to improve biological plausibility by matching streamline density to FOD lobe integrals. |
| [MRtrix3 Tractogram to Connectome](tck2connectome.md) | Constructs a structural connectivity matrix by counting streamlines connecting pairs of regions from a parcellation. |

## FreeSurfer

Docker image: `freesurfer/freesurfer`

### Diffusion

| Tool | Description |
|---|---|
| [FreeSurfer Diffusion Post-Registration Processing](dmri_postreg.md) | Post-registration processing for diffusion MRI data as part of the TRACULA tractography pipeline. |

## AMICO

Docker image: `cookpa/amico-noddi`

### Microstructure Modeling

| Tool | Description |
|---|---|
| [AMICO NODDI Fitting](amico_noddi.md) | Fits the NODDI (Neurite Orientation Dispersion and Density Imaging) model to multi-shell diffusion MRI data using con... |

## AFNI

Docker image: `brainlife/afni`

### Tensor Fitting

| Tool | Description |
|---|---|
| [AFNI Diffusion Tensor Fitting (3dDWItoDT)](3dDWItoDT.md) | Fits a diffusion tensor model to DWI data using linear or nonlinear methods, outputting tensor components, eigenvalue... |

### Uncertainty

| Tool | Description |
|---|---|
| [AFNI DWI Uncertainty Estimation (3dDWUncert)](3dDWUncert.md) | Estimates uncertainty of diffusion tensor parameters via jackknife or bootstrap resampling of DWI data. |

### Tractography

| Tool | Description |
|---|---|
| [AFNI Tractography (3dTrackID)](3dTrackID.md) | Performs deterministic, mini-probabilistic, or full probabilistic white matter tractography using diffusion tensor data. |
