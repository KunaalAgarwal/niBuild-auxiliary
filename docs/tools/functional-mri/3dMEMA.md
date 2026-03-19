# AFNI 3D Mixed Effects Meta Analysis (3dMEMA)

**Library:** AFNI | **Docker Image:** `brainlife/afni`

## Function

Mixed effects meta-analysis for group studies that properly accounts for within and between-subject variance.

**Modality:** Subject-level beta and t-statistic volumes (3D NIfTI/AFNI).

**Typical Use:** Group analysis with proper mixed effects modeling.

## Key Parameters

-set (group name and subject beta+tstat pairs), -groups (group names), -covariates (covariate file), -prefix (output)

## Key Points

Uses both beta and t-stat from each subject. Better for unequal within-subject variance. Requires R.

## Inputs

| Name | Type | Required | Label | Flag |
|---|---|---|---|---|
| `prefix` | `string` | Yes | Output filename prefix | `-prefix` |
| `set` | `record(mema_set)[]` | Yes | Data set specification (SETNAME subject beta_dset t_dset) |  |
| `groups` | `string` | No | Names of 1-2 groups for comparison | `-groups` |
| `mask` | `File` | No | Process voxels within mask only | `-mask` |
| `max_zeros` | `string` | No | Skip voxels with more than N zero beta coefficients | `-max_zeros` |
| `covariates` | `File` | No | Text file with covariate table | `-covariates` |
| `covariates_center` | `string` | No | Centering points for covariates | `-covariates_center` |
| `covariates_model` | `string` | No | Intercept/slope model across groups | `-covariates_model` |
| `HKtest` | `boolean` | No | Apply Hartung-Knapp adjustment to t-statistics | `-HKtest` |
| `model_outliers` | `boolean` | No | Model outlier betas using Laplace distribution | `-model_outliers` |
| `residual_Z` | `boolean` | No | Output residuals and Z-values for outliers | `-residual_Z` |
| `unequal_variance` | `boolean` | No | Model different variability between groups | `-unequal_variance` |
| `missing_data` | `string` | No | Handle missing data (0 or file specification) | `-missing_data` |
| `jobs` | `int` | No | Number of parallel processors | `-jobs` |
| `verb` | `int` | No | Verbosity level (0=quiet) | `-verb` |

### Accepted Input Extensions

- **set**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **mask**: `.nii`, `.nii.gz`, `+orig.HEAD`, `+orig.BRIK`, `+tlrc.HEAD`, `+tlrc.BRIK`
- **covariates**: `.1D`, `.txt`

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

[Official Documentation](https://afni.nimh.nih.gov/pub/dist/doc/program_help/3dMEMA.html)
