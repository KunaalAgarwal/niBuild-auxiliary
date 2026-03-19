# AFNI 3D Seed-Based Correlation (3dTcorr1D)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Computes voxelwise correlation between a 4D dataset and one or more 1D seed time series.

**Modality:** 4D fMRI NIfTI/AFNI time series plus 1D seed time series file.

**Typical Use:** Seed-based functional connectivity analysis.

## Key Parameters

-prefix (output), <4D_dataset> <1D_seed_timeseries>

## Key Points

Simple seed-based correlation. Extract seed time series first (e.g., with 3dmaskave).

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `xset` | `File` | Yes | Input 3D+time dataset |  |
| `y1D` | `File` | Yes | 1D reference time series file |  |
| `prefix` | `string` | Yes | Output dataset prefix | `-prefix` |
| `pearson` | `boolean` | No | Pearson product moment correlation (default) | `-pearson` |
| `spearman` | `boolean` | No | Spearman rank correlation | `-spearman` |
| `quadrant` | `boolean` | No | Quadrant correlation coefficient | `-quadrant` |
| `ktaub` | `boolean` | No | Kendall tau_b coefficient | `-ktaub` |
| `dot` | `boolean` | No | Calculate dot product instead of correlation | `-dot` |
| `Fisher` | `boolean` | No | Apply Fisher (arctanh) transformation | `-Fisher` |
| `mask` | `File` | No | Only process voxels nonzero in mask | `-mask` |
| `float` | `boolean` | No | Save results in float format (default) | `-float` |
| `short` | `boolean` | No | Save results in scaled short format | `-short` |

### Accepted Input Extensions

- **xset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **y1D**: `.1D`, `.txt`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `correlation` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **correlation**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Connectivity

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dTcorr1D.html)
