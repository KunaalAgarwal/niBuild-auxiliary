# Structural MRI

T1/T2-weighted imaging for brain anatomy. Used for skull-stripping, tissue segmentation, cortical reconstruction, and spatial registration.

## FSL

Docker image: `brainlife/fsl`

### Brain Extraction

| Tool | Description |
|---|---|
| [Brain Extraction Tool (BET)](bet.md) | Removes non-brain tissue from MRI images using a deformable surface model that iteratively fits to the brain boundary. |

### Tissue Segmentation

| Tool | Description |
|---|---|
| [FMRIB's Automated Segmentation Tool (FAST)](fast.md) | Segments brain images into gray matter, white matter, and CSF using a hidden Markov random field model with integrate... |
| [FMRIB's Integrated Registration and Segmentation Tool (FIRST)](run_first_all.md) | Multi-step pipeline for subcortical structure segmentation. Internally chains registration, boundary correction, and ... |

### Registration

| Tool | Description |
|---|---|
| [FMRIB's Linear Image Registration Tool (FLIRT)](flirt.md) | Linear (affine) registration between images using optimized cost functions with 6, 7, 9, or 12 degrees of freedom. |
| [FMRIB's Non-linear Image Registration Tool (FNIRT)](fnirt.md) | Non-linear registration using B-spline deformations for precise anatomical alignment to a template. |

### Pipelines

| Tool | Description |
|---|---|
| [FSL Anatomical Processing Pipeline](fsl_anat.md) | Comprehensive automated pipeline for structural T1 processing including reorientation, cropping, bias correction, reg... |
| [Structural Image Evaluation using Normalisation of Atrophy (SIENA)](siena.md) | Multi-step pipeline that estimates percentage brain volume change between two timepoints. Internally chains BET brain... |
| [SIENA Cross-Sectional (SIENAX)](sienax.md) | Multi-step pipeline for cross-sectional brain volume estimation. Internally chains BET brain extraction, atlas regist... |

### Lesion Segmentation

| Tool | Description |
|---|---|
| [Brain Intensity AbNormality Classification Algorithm (BIANCA)](bianca.md) | Automated white matter hyperintensity (WMH) segmentation using supervised machine learning (k-nearest neighbor) train... |

## ANTs

Docker image: `antsx/ants`

### Brain Extraction

| Tool | Description |
|---|---|
| [ANTs Template-Based Brain Extraction](antsBrainExtraction_sh.md) | High-quality brain extraction using registration to a brain template and tissue priors for robust skull stripping. |

### Segmentation

| Tool | Description |
|---|---|
| [ANTs Atropos Tissue Segmentation](Atropos.md) | Probabilistic tissue segmentation using expectation-maximization algorithm with Markov random field spatial prior. |
| [ANTs Combined Atropos with N4 Bias Correction](antsAtroposN4_sh.md) | Iteratively combines N4 bias field correction with Atropos segmentation for improved results on biased images. |

### Registration

| Tool | Description |
|---|---|
| [ANTs Multi-Stage Image Registration](antsRegistration.md) | State-of-the-art image registration supporting multiple stages (rigid, affine, SyN) with configurable metrics and con... |
| [ANTs SyN Registration with Defaults](antsRegistrationSyN_sh.md) | Symmetric normalization registration with sensible default parameters for common registration tasks. |
| [ANTs Quick SyN Registration](antsRegistrationSyNQuick_sh.md) | Fast SyN registration with reduced iterations and coarser sampling for rapid approximate registration. |

### Cortical Thickness

| Tool | Description |
|---|---|
| [ANTs Cortical Thickness Pipeline](antsCorticalThickness_sh.md) | Complete automated pipeline for cortical thickness estimation using DiReCT, including brain extraction, segmentation,... |
| [ANTs DiReCT Cortical Thickness (KellyKapowski)](KellyKapowski.md) | Estimates cortical thickness using the DiReCT algorithm from segmentation data. |

## FreeSurfer

Docker image: `freesurfer/freesurfer`

### Surface Reconstruction

| Tool | Description |
|---|---|
| [FreeSurfer Complete Cortical Reconstruction Pipeline](recon-all.md) | Fully automated pipeline for cortical surface reconstruction and parcellation, including skull stripping, segmentatio... |
| [FreeSurfer MRI Format Conversion (mri_convert)](mri_convert.md) | Converts between neuroimaging file formats (DICOM, NIfTI, MGH/MGZ, ANALYZE, etc.) with optional resampling and confor... |
| [FreeSurfer MRI Watershed Skull Stripping](mri_watershed.md) | Brain extraction using a hybrid watershed/surface deformation algorithm to find the brain-skull boundary. |
| [FreeSurfer MRI Intensity Normalization](mri_normalize.md) | Normalizes T1 image intensities so that white matter has a target intensity value (default 110). |
| [FreeSurfer MRI White Matter Segmentation](mri_segment.md) | Segments white matter from normalized T1 image using intensity thresholding and morphological operations. |
| [FreeSurfer Surface Inflation](mris_inflate.md) | Inflates folded cortical surface to a smooth shape while minimizing metric distortion for visualization. |
| [FreeSurfer Surface to Sphere Mapping](mris_sphere.md) | Maps the inflated cortical surface to a sphere for inter-subject spherical registration. |

### Parcellation

| Tool | Description |
|---|---|
| [FreeSurfer Cortical Parcellation to Volume](mri_aparc2aseg.md) | Combines surface-based cortical parcellation (aparc) with volumetric subcortical segmentation (aseg) into a single vo... |
| [FreeSurfer Annotation to Individual Labels](mri_annotation2label.md) | Extracts individual region labels from a surface annotation file into separate label files. |
| [FreeSurfer Cortical Atlas Labeling](mris_ca_label.md) | Applies a cortical parcellation atlas to an individual subject using trained classifier on spherical surface. |
| [FreeSurfer Label to Volume Conversion](mri_label2vol.md) | Converts surface-based labels to volumetric ROIs using a registration matrix. |

### Morphometry

| Tool | Description |
|---|---|
| [FreeSurfer Surface Anatomical Statistics](mris_anatomical_stats.md) | Computes surface-based morphometric measures (thickness, area, volume, curvature) for each region in a parcellation. |
| [FreeSurfer Segmentation Statistics](mri_segstats.md) | Computes volume and intensity statistics for each region in a segmentation volume. |
| [FreeSurfer Cortical Stats to Group Table](aparcstats2table.md) | Collects cortical parcellation statistics across multiple subjects into a single table for group analysis. |
| [FreeSurfer Subcortical Stats to Group Table](asegstats2table.md) | Collects subcortical segmentation statistics across multiple subjects into a single table. |

## AFNI

Docker image: `brainlife/afni`

### Brain Extraction

| Tool | Description |
|---|---|
| [AFNI 3D Skull Strip](3dSkullStrip.md) | Removes non-brain tissue using a modified spherical surface expansion algorithm adapted from BET. |
| [AFNI Skull Strip and Nonlinear Warp (@SSwarper)](_SSwarper.md) | Combined skull stripping and non-linear warping to template in a single optimized pipeline. |

### Bias Correction

| Tool | Description |
|---|---|
| [AFNI 3D Intensity Uniformization (3dUnifize)](3dUnifize.md) | Corrects intensity inhomogeneity (bias field) to produce uniform white matter intensity. |

### Registration

| Tool | Description |
|---|---|
| [AFNI 3D Affine Registration (3dAllineate)](3dAllineate.md) | Linear (affine) registration with multiple cost functions and optimization methods. |
| [AFNI 3D Nonlinear Warp (3dQwarp)](3dQwarp.md) | Non-linear registration using cubic polynomial basis functions for precise anatomical alignment. |
| [AFNI Automated Talairach Transformation (@auto_tlrc)](_auto_tlrc.md) | Automated Talairach transformation using affine registration to a template atlas. |

## Connectome Workbench

Docker image: `khanlab/connectome-workbench`

### Surface Registration

| Tool | Description |
|---|---|
| [Connectome Workbench Surface Registration Transform](wb_command_surface_sphere_project_unproject.md) | Applies MSM or FreeSurfer spherical registration by projecting coordinates through registered sphere to target space. |
