# AFNI 3D Mask Average (3dmaskave)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Extracts and outputs the average time series from voxels within a mask region.

**Modality:** 4D fMRI NIfTI/AFNI time series plus binary mask.

**Typical Use:** Simple ROI time series extraction for connectivity analysis.

## Key Parameters

-mask (mask dataset), -quiet (output values only), -mrange (min max value range in mask)

## Key Points

Simple and fast ROI time series extraction. Output is one value per timepoint to stdout.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `mask` | `File` | No | Use mask dataset for averaging | `-mask` |
| `mindex` | `int` | No | Which sub-brick from mask to use (default 0) | `-mindex` |
| `mrange` | `string` | No | Restrict mask voxels to values between a and b | `-mrange` |
| `dindex` | `int` | No | Select sub-brick from input dataset | `-dindex` |
| `drange` | `string` | No | Include only input voxels with values between a and b | `-drange` |
| `slices` | `string` | No | Restrict to slice numbers p through q | `-slices` |
| `xbox` | `string` | No | Create mask using box at x y z location | `-xbox` |
| `xball` | `string` | No | Create mask using sphere at x y z with radius r | `-xball` |
| `sigma` | `boolean` | No | Compute standard deviation alongside mean | `-sigma` |
| `sum` | `boolean` | No | Calculate sum instead of mean | `-sum` |
| `sumsq` | `boolean` | No | Calculate sum of squares | `-sumsq` |
| `enorm` | `boolean` | No | Calculate Euclidean norm | `-enorm` |
| `median` | `boolean` | No | Calculate median instead of mean | `-median` |
| `max` | `boolean` | No | Calculate maximum instead of mean | `-max` |
| `min` | `boolean` | No | Calculate minimum instead of mean | `-min` |
| `perc` | `int` | No | Compute the XX-th percentile value (0-100) | `-perc` |
| `dump` | `boolean` | No | Print all voxel values included in result | `-dump` |
| `udump` | `boolean` | No | Print unscaled voxel values | `-udump` |
| `indump` | `boolean` | No | Print voxel indexes for dumped values | `-indump` |
| `quiet` | `boolean` | No | Output only minimal numerical results | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `average` | `stdout` |  |
| `log` | `File` | `3dmaskave.log` |

### Output Extensions

- **average**: `.1D`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > ROI Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dmaskave.html)
