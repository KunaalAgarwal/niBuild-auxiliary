# AFNI 3D ROI Statistics (3dROIstats)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Extracts statistical summary measures from data within defined ROI masks.

**Modality:** 3D or 4D NIfTI/AFNI volume plus ROI mask with integer labels.

**Typical Use:** Extracting mean values from defined regions of interest.

## Key Parameters

-mask (ROI mask), -nzmean (mean of non-zero voxels), -nzvoxels (count non-zero voxels), -minmax (min and max)

## Key Points

Can handle multi-label ROI masks. Outputs one row per volume, one column per ROI.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `input` | `File` | Yes | Input dataset |  |
| `mask` | `File` | Yes | Mask dataset with ROI labels | `-mask` |
| `mask_f2short` | `boolean` | No | Convert float mask to short integers | `-mask_f2short` |
| `numROI` | `int` | No | Assume ROIs numbered 1 to n | `-numROI` |
| `zerofill` | `string` | No | Fill missing ROIs with value | `-zerofill` |
| `roisel` | `File` | No | Consider only ROIs listed in selection file | `-roisel` |
| `nzmean` | `boolean` | No | Mean of non-zero voxels only | `-nzmean` |
| `nzsum` | `boolean` | No | Sum of non-zero voxels | `-nzsum` |
| `nzvoxels` | `boolean` | No | Count non-zero voxels | `-nzvoxels` |
| `nzvolume` | `boolean` | No | Volume of non-zero voxels | `-nzvolume` |
| `minmax` | `boolean` | No | Min/max across all voxels | `-minmax` |
| `nzminmax` | `boolean` | No | Min/max of non-zero voxels | `-nzminmax` |
| `sigma` | `boolean` | No | Standard deviation (all voxels) | `-sigma` |
| `nzsigma` | `boolean` | No | Standard deviation (non-zero voxels) | `-nzsigma` |
| `median` | `boolean` | No | Median (all voxels) | `-median` |
| `nzmedian` | `boolean` | No | Median (non-zero voxels) | `-nzmedian` |
| `summary` | `boolean` | No | Output grand mean only | `-summary` |
| `mode` | `boolean` | No | Mode calculation | `-mode` |
| `key` | `boolean` | No | Output integer ROI identifier | `-key` |
| `quiet` | `boolean` | No | Suppress column/row labels | `-quiet` |
| `nomeanout` | `boolean` | No | Exclude mean column from output | `-nomeanout` |
| `oneDformat` | `boolean` | No | Output as 1D format with commented labels | `-1Dformat` |
| `oneDRformat` | `boolean` | No | Output as 1D format R-compatible | `-1DRformat` |

### Accepted Input Extensions

- **input**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **roisel**: `.1D`, `.txt`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `stdout` |  |
| `log` | `File` | `3dROIstats.log` |

### Output Extensions

- **stats**: `.txt`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > ROI Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dROIstats.html)
