# AFNI 3D MultiVariate Modeling (3dMVM)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Multivariate modeling framework supporting ANOVA/ANCOVA designs with between and within-subject factors.

**Modality:** Subject-level 3D NIfTI/AFNI volumes with data table specifying factors.

**Typical Use:** Complex repeated measures and mixed designs.

## Key Parameters

-dataTable (structured input table), -bsVars (between-subject variables), -wsVars (within-subject variables), -qVars (quantitative variables)

## Key Points

Most flexible group analysis tool in AFNI. Handles complex repeated measures designs. Requires R.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output filename prefix | `-prefix` |
| `table` | `record(mvm_table_row)[]` | Yes | Data table rows (Subj, Group, Cond, InputFile) |  |
| `bsVars` | `string` | No | Between-subjects factors and quantitative variables formula | `-bsVars` |
| `wsVars` | `string` | No | Within-subject factors formula | `-wsVars` |
| `qVars` | `string` | No | Quantitative variables (covariates) list | `-qVars` |
| `qVarCenters` | `string` | No | Centering values for quantitative variables | `-qVarCenters` |
| `num_glt` | `int` | No | Number of general linear t-tests | `-num_glt` |
| `gltLabel` | `string[]` | No | GLT labels (k label pairs) | `-gltLabel` |
| `gltCode` | `string[]` | No | GLT coding specifications | `-gltCode` |
| `num_glf` | `int` | No | Number of general linear F-tests | `-num_glf` |
| `glfLabel` | `string[]` | No | GLF labels | `-glfLabel` |
| `glfCode` | `string[]` | No | GLF coding specifications | `-glfCode` |
| `mVar` | `string` | No | Treat within-subject levels as simultaneous variables | `-mVar` |
| `SS_type` | `int` | No | Sum of squares type (2 or 3) | `-SS_type` |
| `wsMVT` | `boolean` | No | Within-subject multivariate testing | `-wsMVT` |
| `SC` | `boolean` | No | Output sphericity-corrected F-statistics | `-SC` |
| `GES` | `boolean` | No | Report generalized eta-squared effect sizes | `-GES` |
| `mask` | `File` | No | Process voxels within mask only | `-mask` |
| `jobs` | `int` | No | Number of parallel processors | `-jobs` |

### Accepted Input Extensions

- **table**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dMVM.html)
