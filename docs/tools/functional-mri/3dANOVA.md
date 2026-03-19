# AFNI 3D One-Way ANOVA

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Voxelwise fixed-effects one-way analysis of variance.

**Modality:** Multiple 3D NIfTI/AFNI volumes organized by factor level.

**Typical Use:** Single-factor group analysis.

## Key Parameters

-levels (number of levels), -dset (level dataset), -ftr (F-test output), -mean (level means output)

## Key Points

Fixed-effects only. For random/mixed effects, use 3dMVM or 3dLME instead.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `levels` | `int` | Yes | Number of factor levels |  |
| `dset` | `record(unnamed)[]` | Yes | Dataset specifications (level filename pairs) |  |
| `bucket` | `string` | Yes | Output bucket dataset prefix |  |
| `ftr` | `string` | No | F-statistic for treatment effect output prefix |  |
| `mean` | `string[]` | No | Estimate of factor level mean (level prefix pairs) | `-mean` |
| `diff` | `string[]` | No | Difference between factor levels (level1 level2 prefix) | `-diff` |
| `contr` | `string[]` | No | Contrast in factor levels (coefficients prefix) | `-contr` |
| `mask` | `File` | No | Mask dataset | `-mask` |
| `voxel` | `int` | No | Screen output for specific voxel | `-voxel` |
| `debug` | `int` | No | Debug level | `-debug` |
| `old_method` | `boolean` | No | Use previous ANOVA computation approach | `-old_method` |
| `OK` | `boolean` | No | Confirm understanding of contrast limitations | `-OK` |
| `assume_sph` | `boolean` | No | Assume sphericity for zero-sum contrasts | `-assume_sph` |

### Accepted Input Extensions

- **dset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.bucket)+orig.HEAD`, `$(inputs.bucket)+tlrc.HEAD` |
| `f_stat` | `File` | `$(inputs.ftr)+orig.HEAD`, `$(inputs.ftr)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.bucket).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **f_stat**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dANOVA.html)
