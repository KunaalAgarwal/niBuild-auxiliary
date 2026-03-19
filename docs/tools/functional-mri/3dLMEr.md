# AFNI 3D Linear Mixed Effects with R (3dLMEr)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Linear mixed effects with direct R formula syntax integration for flexible model specification.

**Modality:** Subject-level 3D NIfTI/AFNI volumes with data table.

**Typical Use:** Flexible mixed effects with R formula syntax.

## Key Parameters

-dataTable (input table), -model (R lmer formula), -qVars (quantitative variables), -gltCode (contrast specification)

## Key Points

More flexible than 3dLME. Uses lmerTest for degrees of freedom. Accepts full R formula syntax.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output filename prefix | `-prefix` |
| `table` | `record(lmer_table_row)[]` | Yes | Data table rows (Subj, Cond, InputFile) |  |
| `model` | `string` | Yes | Fixed effects formula in R lmer syntax | `-model` |
| `qVars` | `string` | No | Quantitative variables (comma-separated) | `-qVars` |
| `qVarCenters` | `string` | No | Centering values for quantitative variables | `-qVarCenters` |
| `vVars` | `string` | No | Voxel-wise covariates | `-vVars` |
| `vVarCenters` | `string` | No | Centering values for voxel-wise covariates | `-vVarCenters` |
| `num_glt` | `int` | No | Number of general linear t-tests | `-num_glt` |
| `gltLabel` | `string[]` | No | GLT labels | `-gltLabel` |
| `gltCode` | `string[]` | No | GLT coding specifications | `-gltCode` |
| `num_glf` | `int` | No | Number of general linear F-tests | `-num_glf` |
| `glfLabel` | `string[]` | No | GLF labels | `-glfLabel` |
| `glfCode` | `string[]` | No | GLF coding specifications | `-glfCode` |
| `SS_type` | `int` | No | Sum of squares type (1=sequential, 3=marginal) | `-SS_type` |
| `bounds` | `string` | No | Outlier removal range (lb ub) | `-bounds` |
| `ML` | `boolean` | No | Use Maximum Likelihood instead of REML | `-ML` |
| `resid` | `string` | No | Output filename for residuals | `-resid` |
| `RE` | `string` | No | Random effects to save | `-RE` |
| `REprefix` | `string` | No | Output filename for random effects | `-REprefix` |
| `mask` | `File` | No | Process voxels within mask only | `-mask` |
| `jobs` | `int` | No | Number of parallel processors | `-jobs` |

### Accepted Input Extensions

- **table**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Outputs

| Name | Type | Glob Pattern |
|---|---|---|
| `stats` | `File` | `$(inputs.prefix)+orig.HEAD`, `$(inputs.prefix)+tlrc.HEAD` |
| `residuals` | `File` | `$(inputs.resid)+orig.HEAD`, `$(inputs.resid)+tlrc.HEAD` |
| `random_effects` | `File` | `$(inputs.REprefix)+orig.HEAD`, `$(inputs.REprefix)+tlrc.HEAD` |
| `log` | `File` | `$(inputs.prefix).log` |

### Output Extensions

- **stats**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **residuals**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **random_effects**: `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`

## Docker Tags

Available versions: `latest`, `16.3.0`

## Categories

- Functional MRI > AFNI > Statistical Analysis

## Documentation

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dLMEr.html)
