# Utilities

General-purpose neuroimaging utilities. Used for format conversion, image math, resampling, and quality control.

## FSL

Docker image: `brainlife/fsl`

### Image Math

| Tool | Description |
|---|---|
| [FSL Mathematical Image Operations (fslmaths)](fslmaths.md) | Performs a wide range of voxelwise mathematical operations on NIfTI images including arithmetic, filtering, threshold... |
| [FSL Image Statistics (fslstats)](fslstats.md) | Computes various summary statistics from image data, optionally within a mask region. |
| [FSL Region of Interest Extraction (fslroi)](fslroi.md) | Extracts a spatial or temporal sub-region from NIfTI images. |
| [FSL Mean Time Series Extraction (fslmeants)](fslmeants.md) | Extracts the mean time series from a 4D dataset within a mask or at specified coordinates. |

### Volume Operations

| Tool | Description |
|---|---|
| [FSL Volume Split (fslsplit)](fslsplit.md) | Splits a 4D time series into individual 3D volumes or splits along any spatial axis. |
| [FSL Volume Merge (fslmerge)](fslmerge.md) | Concatenates multiple 3D volumes into a 4D time series or merges along any spatial axis. |
| [FSL Reorient to Standard Orientation](fslreorient2std.md) | Reorients images to match standard (MNI) orientation using 90-degree rotations and flips only. |
| [FSL Robust Field of View Reduction](robustfov.md) | Automatically identifies and removes neck/non-brain tissue by estimating the brain center and reducing the field of v... |
| [FSL Change File Type (fslchfiletype)](fslchfiletype.md) | Converts neuroimaging files between NIfTI and ANALYZE file formats. |

### Warp Utilities

| Tool | Description |
|---|---|
| [FSL Apply Warp Field (applywarp)](applywarp.md) | Applies linear and/or non-linear warp fields to transform images between coordinate spaces. |
| [FSL Invert Warp Field (invwarp)](invwarp.md) | Computes the inverse of a non-linear warp field for reverse transformations. |
| [FSL Convert/Combine Warps (convertwarp)](convertwarp.md) | Combines multiple warp fields and affine matrices into a single composite warp for efficient one-step transformation. |

### Clustering

| Tool | Description |
|---|---|
| [FSL Cluster Analysis (cluster)](cluster.md) | Identifies contiguous clusters of suprathreshold voxels in statistical images and reports their properties. |

### Image Info

| Tool | Description |
|---|---|
| [FSL Header Display (fslhd)](fslhd.md) | Displays NIfTI/ANALYZE image header information including dimensions, voxel sizes, data type, and orientation. |
| [FSL Image Info (fslinfo)](fslinfo.md) | Displays concise image dimension and voxel size information from a NIfTI header. |

## AFNI

Docker image: `brainlife/afni`

### Image Math

| Tool | Description |
|---|---|
| [AFNI 3D Voxelwise Calculator (3dcalc)](3dcalc.md) | Voxelwise mathematical calculator supporting extensive expression syntax for operations on one or more datasets. |
| [AFNI 3D Temporal Statistics (3dTstat)](3dTstat.md) | Computes voxelwise temporal statistics (mean, stdev, median, etc.) across a 4D time series. |

### Dataset Operations

| Tool | Description |
|---|---|
| [AFNI 3D Dataset Information (3dinfo)](3dinfo.md) | Displays header information and metadata from AFNI/NIfTI datasets. |
| [AFNI 3D Dataset Copy (3dcopy)](3dcopy.md) | Copies a dataset with optional format conversion between AFNI and NIfTI formats. |
| [AFNI 3D Zero Padding (3dZeropad)](3dZeropad.md) | Adds zero-valued slices around dataset boundaries to extend the image matrix. |
| [AFNI 3D Temporal Concatenate (3dTcat)](3dTcat.md) | Concatenates datasets along the time dimension or selects specific sub-bricks from 4D data. |

### ROI Utilities

| Tool | Description |
|---|---|
| [AFNI 3D Undump (Coordinate to Volume)](3dUndump.md) | Creates a 3D dataset from a text file containing voxel coordinates and values. |
| [AFNI Atlas Location Query (whereami)](whereami.md) | Reports anatomical atlas labels for given coordinates or identifies regions in multiple atlases simultaneously. |
| [AFNI 3D Resample (3dresample)](3dresample.md) | Resamples a dataset to match the grid of another dataset or to a specified voxel size. |
| [AFNI 3D Fractionize (ROI Resampling)](3dfractionize.md) | Resamples ROI/atlas datasets using fractional occupancy to maintain region representation at different resolutions. |

### Warp Utilities

| Tool | Description |
|---|---|
| [AFNI 3D Nonlinear Warp Apply](3dNwarpApply.md) | Applies precomputed nonlinear warps (from 3dQwarp) to transform datasets. |
| [AFNI 3D Nonlinear Warp Concatenate](3dNwarpCat.md) | Concatenates multiple nonlinear warps and affine matrices into a single combined warp. |

## ANTs

Docker image: `antsx/ants`

### Preprocessing Utilities

| Tool | Description |
|---|---|
| [ANTs N4 Bias Field Correction](N4BiasFieldCorrection.md) | Advanced bias field (intensity inhomogeneity) correction using the N4 algorithm with iterative B-spline fitting. |
| [ANTs Non-Local Means Denoising](DenoiseImage.md) | Reduces noise in MRI images using an adaptive non-local means algorithm that preserves structural details. |

### Image Operations

| Tool | Description |
|---|---|
| [ANTs Image Math Operations](ImageMath.md) | Versatile tool for image arithmetic, morphological operations, distance transforms, and various measurements. |
| [ANTs Image Thresholding](ThresholdImage.md) | Applies various thresholding methods to create binary masks, including Otsu and k-means adaptive thresholding. |

### Label Analysis

| Tool | Description |
|---|---|
| [ANTs Label Geometry Measures](LabelGeometryMeasures.md) | Computes geometric properties (volume, centroid, bounding box, eccentricity) for each labeled region in a parcellation. |
| [ANTs Joint Label Fusion](antsJointLabelFusion_sh.md) | Multi-atlas segmentation that combines labels from multiple pre-labeled atlases using joint label fusion with local w... |

### Transform Utilities

| Tool | Description |
|---|---|
| [ANTs Apply Transforms](antsApplyTransforms.md) | Applies one or more precomputed transformations (affine + warp) to images, applying transforms in reverse order of sp... |

## FreeSurfer

Docker image: `freesurfer/freesurfer`

### Format Conversion

| Tool | Description |
|---|---|
| [FreeSurfer MRI Format Conversion (mri_convert)](../structural-mri/mri_convert.md) | Converts between neuroimaging file formats (DICOM, NIfTI, MGH/MGZ, ANALYZE, etc.) with optional resampling and confor... |

## dcm2niix

Docker image: `xnat/dcm2niix`

### Format Conversion

| Tool | Description |
|---|---|
| [DICOM to NIfTI Converter (dcm2niix)](dcm2niix.md) | Converts DICOM medical images to NIfTI format with BIDS-compatible JSON sidecar files, preserving acquisition metadata. |
