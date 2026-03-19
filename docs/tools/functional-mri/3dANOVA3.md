# AFNI 3D Three-Way ANOVA

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Voxelwise fixed-effects three-way analysis of variance.

**Modality:** Multiple 3D NIfTI/AFNI volumes organized by three factors.

**Typical Use:** Three-factor factorial designs.

## Key Parameters

-type (1-5), -alevels/-blevels/-clevels, -dset, -fa/-fb/-fc/-fab/-fac/-fbc/-fabc (F-tests)

## Key Points

Extension of 3dANOVA2 to three factors. Consider 3dMVM for more flexible modeling.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `type` | `int` | Yes | ANOVA model type (1-5 for different random/fixed combinations) |  |
| `alevels` | `int` | Yes | Number of levels for factor A |  |
| `blevels` | `int` | Yes | Number of levels for factor B |  |
| `clevels` | `int` | Yes | Number of levels for factor C |  |
| `dset` | `record(anova3_dset)[]` | Yes | Dataset specifications (level_A level_B level_C filename) |  |
| `bucket` | `string` | Yes | Output bucket dataset prefix |  |
| `fa` | `string` | No | F-statistic for factor A |  |
| `fb` | `string` | No | F-statistic for factor B |  |
| `fc` | `string` | No | F-statistic for factor C |  |
| `fab` | `string` | No | F-statistic for A x B interaction | `-fab` |
| `fac` | `string` | No | F-statistic for A x C interaction | `-fac` |
| `fbc` | `string` | No | F-statistic for B x C interaction | `-fbc` |
| `fabc` | `string` | No | F-statistic for A x B x C interaction | `-fabc` |
| `amean` | `string[]` | No | Mean for level of factor A | `-amean` |
| `bmean` | `string[]` | No | Mean for level of factor B | `-bmean` |
| `cmean` | `string[]` | No | Mean for level of factor C | `-cmean` |
| `mask` | `File` | No | Mask dataset | `-mask` |
| `debug` | `int` | No | Debug level | `-debug` |

### Accepted Input Extensions

- **dset**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.bucket)+orig.HEAD`, `$(inputs.bucket)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.bucket).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dANOVA3.html)
