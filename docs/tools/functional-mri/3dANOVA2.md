# AFNI 3D Two-Way ANOVA

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Voxelwise fixed-effects two-way analysis of variance with main effects and interaction.

**Modality:** Multiple 3D NIfTI/AFNI volumes organized by two factors.

**Typical Use:** Two-factor factorial designs.

## Key Parameters

-type (1-5, model type), -alevels/-blevels (factor levels), -dset (datasets), -fa/-fb/-fab (F-tests)

## Key Points

Type determines fixed/random effects per factor. Types 1-3 for within-subject designs.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `type` | `int` | Yes | ANOVA model type (1=random A, 2=random B, 3=both fixed) |  |
| `alevels` | `int` | Yes | Number of levels for factor A |  |
| `blevels` | `int` | Yes | Number of levels for factor B |  |
| `dset` | `record(anova2_dset)[]` | Yes | Dataset specifications (level_A level_B filename) |  |
| `bucket` | `string` | Yes | Output bucket dataset prefix |  |
| `fa` | `string` | No | F-statistic for factor A |  |
| `fb` | `string` | No | F-statistic for factor B |  |
| `fab` | `string` | No | F-statistic for interaction |  |
| `amean` | `string[]` | No | Mean for level of factor A (level prefix) | `-amean` |
| `bmean` | `string[]` | No | Mean for level of factor B (level prefix) | `-bmean` |
| `adiff` | `string[]` | No | Difference between levels of A (level1 level2 prefix) | `-adiff` |
| `bdiff` | `string[]` | No | Difference between levels of B (level1 level2 prefix) | `-bdiff` |
| `acontr` | `string[]` | No | Contrast for factor A | `-acontr` |
| `bcontr` | `string[]` | No | Contrast for factor B | `-bcontr` |
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

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dANOVA2.html)
