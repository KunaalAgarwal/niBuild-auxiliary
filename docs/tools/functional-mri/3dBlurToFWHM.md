# AFNI 3D Adaptive Smoothing to Target FWHM

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Adaptively smooths data to achieve a target smoothness level, accounting for existing smoothness.

**Modality:** 3D or 4D NIfTI/AFNI volume with mask.

**Typical Use:** Achieving consistent smoothness across subjects/studies.

## Key Parameters

-input (input dataset), -prefix (output), -FWHM (target smoothness in mm), -mask (brain mask)

## Key Points

Measures existing smoothness and adds only enough to reach target FWHM. Better than fixed-kernel smoothing.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset to be smoothed | `-input` |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `FWHM` | `double` | No | Target 3D FWHM in mm | `-FWHM` |
| `FWHMxy` | `double` | No | Target 2D (x,y)-plane FWHM in mm (no z-axis blurring) | `-FWHMxy` |
| `blurmaster` | `File` | No | Reference dataset controlling smoothness | `-blurmaster` |
| `mask` | `File` | No | Mask dataset limiting blurring to masked voxels | `-mask` |
| `automask` | `boolean` | No | Generate automatic mask from input dataset | `-automask` |
| `maxite` | `int` | No | Maximum iteration count | `-maxite` |
| `rate` | `double` | No | Scaling factor adjusting blurring speed (0.05-3.5) | `-rate` |
| `nbhd` | `string` | No | Neighborhood for local smoothness computation | `-nbhd` |
| `ACF` | `boolean` | No | Use autocorrelation function method for smoothness estimation | `-ACF` |
| `detrend` | `boolean` | No | Remove polynomial trends from blurmaster (default) | `-detrend` |
| `nodetrend` | `boolean` | No | Disable detrending | `-nodetrend` |
| `detin` | `boolean` | No | Detrend input dataset before and after blurring | `-detin` |
| `unif` | `boolean` | No | Standardize voxel-wise MAD before blurring | `-unif` |
| `temper` | `boolean` | No | Enhance spatial uniformity of smoothness | `-temper` |
| `quiet` | `boolean` | No | Suppress verbose progress messages | `-quiet` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **blurmaster**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `blurred` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **blurred**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Smoothing

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dBlurToFWHM.html)
