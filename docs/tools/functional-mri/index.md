# Functional MRI

BOLD-contrast imaging for brain activity. Used for motion correction, slice timing, spatial smoothing, temporal filtering, and statistical modeling.

## FSL

Docker image: `brainlife/fsl`

### Motion Correction

| Tool | Description |
|---|---|
| [Motion Correction using FLIRT (MCFLIRT)](mcflirt.md) | Intra-modal motion correction for fMRI time series using rigid-body (6-DOF) transformations optimized for fMRI data. |

### Slice Timing

| Tool | Description |
|---|---|
| [FMRIB's Slice Timing Correction (SliceTimer)](slicetimer.md) | Corrects for differences in slice acquisition times within each volume using sinc interpolation. |

### Distortion Correction

| Tool | Description |
|---|---|
| [FMRIB's Utility for Geometrically Unwarping EPIs (FUGUE)](fugue.md) | Corrects geometric distortions in EPI images caused by magnetic field inhomogeneity using acquired fieldmap data. |
| [Tool for Estimating and Correcting Susceptibility-Induced Distortions (TOPUP)](topup.md) | Estimates and corrects susceptibility-induced distortions using pairs of images with reversed phase-encode directions. |
| [FSL Apply Topup Distortion Correction](applytopup.md) | Applies the susceptibility-induced off-resonance field estimated by topup to correct distortions in EPI images. |
| [FSL Fieldmap Preparation](fsl_prepare_fieldmap.md) | Prepares a fieldmap for use with FUGUE by converting phase difference images to radians per second. |
| [FSL Phase Region Expanding Labeller for Unwrapping Discrete Estimates (PRELUDE)](prelude.md) | Performs 3D phase unwrapping on wrapped phase images using a region-growing algorithm. |

### Smoothing

| Tool | Description |
|---|---|
| [Smallest Univalue Segment Assimilating Nucleus (SUSAN)](susan.md) | Edge-preserving noise reduction using nonlinear filtering that smooths within tissue boundaries while preserving edges. |

### Statistical Analysis

| Tool | Description |
|---|---|
| [FMRIB's Improved Linear Model (FILM)](film_gls.md) | Fits general linear model to fMRI time series with prewhitening using autocorrelation correction. |
| [FMRIB's Local Analysis of Mixed Effects (FLAME)](flameo.md) | Group-level mixed-effects analysis accounting for both within-subject and between-subject variance using MCMC-based B... |
| [FSL Randomise Permutation Testing](randomise.md) | Non-parametric permutation testing for statistical inference with multiple correction methods including TFCE. |

### ICA/Denoising

| Tool | Description |
|---|---|
| [Multivariate Exploratory Linear Optimized Decomposition into Independent Components (MELODIC)](melodic.md) | Multi-step ICA pipeline that decomposes fMRI data into spatially independent components. Internally chains brain mask... |
| [FSL Dual Regression](dual_regression.md) | Multi-step pipeline that projects group-level ICA spatial maps back to individual subjects. Internally chains spatial... |
| [FSL Component Regression Filter (fsl_regfilt)](fsl_regfilt.md) | Removes nuisance components from 4D fMRI data by regressing out specified columns from a design or mixing matrix. |

### Pipelines

| Tool | Description |
|---|---|
| [FMRI Expert Analysis Tool (FEAT)](feat.md) | Complete fMRI analysis pipeline combining preprocessing (motion correction, spatial smoothing, temporal filtering), f... |

## AFNI

Docker image: `brainlife/afni`

### Motion Correction

| Tool | Description |
|---|---|
| [AFNI 3D Volume Registration (3dvolreg)](3dvolreg.md) | Rigid-body motion correction by registering all volumes in a 4D dataset to a base volume. |

### Slice Timing

| Tool | Description |
|---|---|
| [AFNI 3D Temporal Shift (3dTshift)](3dTshift.md) | Corrects for slice timing differences by shifting each voxel time series to a common temporal reference. |

### Denoising

| Tool | Description |
|---|---|
| [AFNI 3D Despike (3dDespike)](3dDespike.md) | Removes transient signal spikes from fMRI time series using an L1-norm fitting approach. |
| [AFNI 3D Bandpass Filter (3dBandpass)](3dBandpass.md) | Applies temporal bandpass filtering to fMRI time series with optional simultaneous nuisance regression. |

### Smoothing

| Tool | Description |
|---|---|
| [AFNI 3D Adaptive Smoothing to Target FWHM](3dBlurToFWHM.md) | Adaptively smooths data to achieve a target smoothness level, accounting for existing smoothness. |
| [AFNI 3D Merge and Smooth (3dmerge)](3dmerge.md) | Combines spatial filtering and dataset merging operations, commonly used for Gaussian smoothing. |

### Masking

| Tool | Description |
|---|---|
| [AFNI 3D Automatic Mask Creation (3dAutomask)](3dAutomask.md) | Creates a brain mask automatically from EPI data by finding connected high-intensity voxels. |

### Registration

| Tool | Description |
|---|---|
| [AFNI align_epi_anat — EPI-to-Anatomy Alignment](align_epi_anat.md) | Aligns EPI functional images to anatomical images with optional distortion correction using local Pearson correlation. |

### Statistical Analysis

| Tool | Description |
|---|---|
| [AFNI 3D Deconvolve (GLM Analysis)](3dDeconvolve.md) | Multiple linear regression analysis for fMRI with flexible hemodynamic response function models. |
| [AFNI 3D REML Fit (Improved GLM)](3dREMLfit.md) | GLM with ARMA(1,1) temporal autocorrelation correction using restricted maximum likelihood estimation. |
| [AFNI 3D Mixed Effects Meta Analysis (3dMEMA)](3dMEMA.md) | Mixed effects meta-analysis for group studies that properly accounts for within and between-subject variance. |
| [AFNI 3D One-Way ANOVA](3dANOVA.md) | Voxelwise fixed-effects one-way analysis of variance. |
| [AFNI 3D Two-Way ANOVA](3dANOVA2.md) | Voxelwise fixed-effects two-way analysis of variance with main effects and interaction. |
| [AFNI 3D Three-Way ANOVA](3dANOVA3.md) | Voxelwise fixed-effects three-way analysis of variance. |
| [AFNI 3D T-Test (3dttest++)](3dttest__.md) | Two-sample t-test with support for covariates, paired tests, and cluster-level inference. |
| [AFNI 3D MultiVariate Modeling (3dMVM)](3dMVM.md) | Multivariate modeling framework supporting ANOVA/ANCOVA designs with between and within-subject factors. |
| [AFNI 3D Linear Mixed Effects (3dLME)](3dLME.md) | Linear mixed effects modeling using R lme4 package for designs with random effects. |
| [AFNI 3D Linear Mixed Effects with R (3dLMEr)](3dLMEr.md) | Linear mixed effects with direct R formula syntax integration for flexible model specification. |

### Multiple Comparisons

| Tool | Description |
|---|---|
| [AFNI 3D Cluster Size Simulation (3dClustSim)](3dClustSim.md) | Simulates null distribution of cluster sizes for determining cluster-extent thresholds that control family-wise error... |
| [AFNI 3D Smoothness Estimation (3dFWHMx)](3dFWHMx.md) | Estimates spatial smoothness of data using the autocorrelation function (ACF) model. |

### Connectivity

| Tool | Description |
|---|---|
| [AFNI 3D Network Correlation Matrix (3dNetCorr)](3dNetCorr.md) | Computes pairwise correlation matrices between ROI time series extracted from a parcellation atlas. |
| [AFNI 3D Seed-Based Correlation (3dTcorr1D)](3dTcorr1D.md) | Computes voxelwise correlation between a 4D dataset and one or more 1D seed time series. |
| [AFNI 3D Whole-Brain Correlation Map (3dTcorrMap)](3dTcorrMap.md) | Computes various whole-brain voxelwise correlation metrics including average correlation and global connectivity. |
| [AFNI 3D Resting State Functional Connectivity (3dRSFC)](3dRSFC.md) | Computes resting-state frequency-domain metrics including ALFF, fALFF, mALFF, and RSFA from bandpass-filtered data. |

### ROI Analysis

| Tool | Description |
|---|---|
| [AFNI 3D ROI Statistics (3dROIstats)](3dROIstats.md) | Extracts statistical summary measures from data within defined ROI masks. |
| [AFNI 3D Mask Average (3dmaskave)](3dmaskave.md) | Extracts and outputs the average time series from voxels within a mask region. |

## FreeSurfer

Docker image: `freesurfer/freesurfer`

### Functional Analysis

| Tool | Description |
|---|---|
| [FreeSurfer Boundary-Based Registration (bbregister)](bbregister.md) | High-quality registration of functional EPI images to FreeSurfer anatomy using white matter boundary contrast. |
| [FreeSurfer Volume to Surface Projection](mri_vol2surf.md) | Projects volumetric data (fMRI, PET, etc.) onto the cortical surface using specified sampling method. |
| [FreeSurfer Surface to Volume Projection](mri_surf2vol.md) | Projects surface-based data back to volumetric space using registration and template volume. |
| [FreeSurfer Surface Data Preprocessing for Group Analysis](mris_preproc.md) | Concatenates surface data across subjects onto a common template surface for group-level analysis. |
| [FreeSurfer General Linear Model (mri_glmfit)](mri_glmfit.md) | Fits a general linear model on surface or volume data for group-level statistical analysis. |

## ANTs

Docker image: `antsx/ants`

### Motion Correction

| Tool | Description |
|---|---|
| [ANTs Motion Correction](antsMotionCorr.md) | Motion correction for time series data using ANTs registration framework with rigid or affine transformations. |

## fMRIPrep

Docker image: `nipreps/fmriprep`

### Pipeline

| Tool | Description |
|---|---|
| [fMRIPrep: Robust fMRI Preprocessing Pipeline](fmriprep.md) | Automated, robust preprocessing pipeline for task-based and resting-state fMRI, combining tools from FSL, FreeSurfer,... |

## MRIQC

Docker image: `nipreps/mriqc`

### Pipeline

| Tool | Description |
|---|---|
| [MRIQC: MRI Quality Control Pipeline](mriqc.md) | Multi-step quality control pipeline. Internally chains brain extraction, spatial normalization, and computation of do... |

## ICA-AROMA

Docker image: `rtrhd/ica-aroma`

### Denoising

| Tool | Description |
|---|---|
| [ICA-based Automatic Removal of Motion Artifacts (ICA-AROMA)](ICA_AROMA.md) | Multi-step denoising pipeline for fMRI motion artifact removal. Internally chains MELODIC ICA decomposition, motion a... |

## Connectome Workbench

Docker image: `khanlab/connectome-workbench`

### CIFTI Operations

| Tool | Description |
|---|---|
| [Connectome Workbench CIFTI Dense Timeseries Creation](wb_command_cifti_create_dense_timeseries.md) | Creates a CIFTI dense timeseries file (.dtseries.nii) combining cortical surface data with subcortical volume data in... |
| [Connectome Workbench CIFTI Separate](wb_command_cifti_separate.md) | Extracts surface or volume components from a CIFTI file into separate GIFTI metric or NIfTI volume files. |

### Surface Smoothing

| Tool | Description |
|---|---|
| [Connectome Workbench CIFTI Smoothing](wb_command_cifti_smoothing.md) | Applies geodesic Gaussian smoothing to CIFTI data on cortical surfaces and Euclidean smoothing in subcortical volumes. |
| [Connectome Workbench Surface Metric Smoothing](wb_command_metric_smoothing.md) | Applies geodesic Gaussian smoothing to surface metric data following the cortical surface geometry. |
